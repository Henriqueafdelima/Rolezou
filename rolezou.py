from flask import Flask, render_template, request, redirect, url_for, session, flash
from werkzeug.security import generate_password_hash, check_password_hash
import mysql.connector
import secrets
import os
from werkzeug.utils import secure_filename
from datetime import date

app = Flask(__name__)
app.secret_key = secrets.token_hex(32)  # Chave secreta para usar flash messages
app.config['UPLOAD_FOLDER'] = 'static/uploads'
app.config['ALLOWED_EXTENSIONS'] = ['png', 'jpg', 'jpeg', 'gif']

# Configurações do banco de dados
db_config = {
    'user': 'root',
    'password': 'Vencedor4s',
    'host': 'localhost',
    'database': 'rolezou'
}

# Função para verificar se o usuário está autenticado
def esta_autenticado():
    return 'usuario' in session


def get_db_connection():
    return mysql.connector.connect(**db_config)

def allowed_file(filename):
    return '.' in filename and filename.rsplit('.', 1)[1].lower() in app.config['ALLOWED_EXTENSIONS']

# Rota para a página de login
@app.route('/', methods=['GET', 'POST'])
def login():
    if request.method == 'POST':
        nick = request.form['nickname']
        password = request.form['senha']
        
        if verificar_credenciais(nick, password):
            session['usuario'] = nick  # Criar sessão de usuário
            #flash('Login bem-sucedido!', 'success')
            #flash(f'Bem-vindo, {nick}!', 'info')
            return redirect(url_for('index'))
        else:
            flash('Credenciais inválidas. Tente novamente.', 'danger')
    
    return render_template('login.html')

# Rota para a página de cadastro
@app.route('/cadastro', methods=['GET', 'POST'])
def cadastro():
    if request.method == 'POST':
        nick = request.form['nickname']
        primeiro_nome = request.form['nome']
        ultimo_nome = request.form['sobrenome']
        email = request.form['email']
        telefone = request.form['telefone']
        senha = request.form['senha']
        
        if nick and primeiro_nome and ultimo_nome and email and telefone and senha:
            try:
                conn = get_db_connection()
                cursor = conn.cursor()
                
                # Gerar hash da senha antes de armazenar no banco de dados
                password_hash = generate_password_hash(senha)
                
                cursor.execute("INSERT INTO usuarios (nick, primeiro_nome, ultimo_nome, email, telefone, password_hash) VALUES (%s, %s, %s, %s, %s, %s)",
                 (nick, primeiro_nome, ultimo_nome, email, telefone, password_hash))
                conn.commit()
                
                flash('Usuário registrado com sucesso!', 'success')
                return redirect(url_for('cadastro'))
            except mysql.connector.Error as err:
                flash(f'Erro ao registrar usuário: {err}', 'danger')
            finally:
                cursor.close()
                conn.close()
        else:
            flash('Por favor, preencha todos os campos!', 'warning')
    
    return render_template('cadastro.html')

# Rota para fazer logout
@app.route('/logout')
def logout():
    session.pop('usuario', None)  # Encerrar sessão do usuário
    flash('Você foi desconectado com sucesso.', 'info')
    return redirect(url_for('login'))

@app.route('/index', methods=['GET', 'POST'])
def index():
    if not esta_autenticado():
        flash('Você precisa fazer login para acessar esta página.', 'warning')
        return redirect(url_for('login'))

    ordenar_por = request.args.get('ordenar_por')

    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)

    query = """
        SELECT e.registro_evento, e.nome_evento, e.descricao, e.endereco, 
               DATE_FORMAT(e.data_evento, '%d/%m/%Y') AS data_formatada, 
               e.horario_evento, e.preco, e.imagem, e.criado_por, 
               COALESCE(AVG(a.nota), 0) as media_avaliacao,
               COUNT(a.nota) as num_avaliacoes
        FROM eventos e
        LEFT JOIN avaliacoes a ON e.registro_evento = a.registro_evento
        GROUP BY e.registro_evento, e.nome_evento, e.descricao, e.endereco, 
                 e.data_evento, e.horario_evento, e.preco, e.imagem, e.criado_por
    """

    if ordenar_por == 'data_recente':
        query += " ORDER BY e.data_evento ASC"
    elif ordenar_por == 'data_distante':
        query += " ORDER BY e.data_evento DESC"
    elif ordenar_por == 'maior_valor':
        query += " ORDER BY e.preco DESC"
    elif ordenar_por == 'menor_valor':
        query += " ORDER BY e.preco ASC"
    elif ordenar_por == 'avaliacao':
        query += " ORDER BY media_avaliacao DESC"

    cursor.execute(query)
    eventos = cursor.fetchall()
    cursor.close()
    conn.close()

    return render_template('index.html', eventos=eventos, ordenar_por=ordenar_por)




 


@app.route('/criar_evento', methods=['GET', 'POST'])
def criar_evento():
    if not esta_autenticado():
        flash('Você precisa fazer login para acessar esta página.', 'warning')
        return redirect(url_for('login'))
    
    if request.method == 'POST':
        titulo = request.form['titulo']
        descricao = request.form['descricao']
        endereco = request.form['endereco']
        cep = request.form['cep']
        data = request.form['data']
        horario = request.form['horario_evento']
        file = request.files['imagem']
        preco = request.form['preco']
        criador = session['usuario']




        criador_id = None
        try:
            conn = get_db_connection()
            cursor = conn.cursor()
            cursor.execute("SELECT registro_usuario FROM usuarios WHERE nick = %s", (criador,))
            result = cursor.fetchone()
            if result:
                criador_id = result[0]  # Certifique-se de que você está acessando o primeiro elemento da tupla
            cursor.close()
            conn.close()
        except mysql.connector.Error as err:
            flash(f'Erro ao buscar ID do criador: {err}', 'danger')
            return redirect(url_for('index'))

        if not criador_id:
            flash('Erro ao buscar o ID do criador.', 'danger')
            return redirect(url_for('index'))

         # Obter o ID do usuário criador
        criador_id = None
        conn = get_db_connection()
        cursor = conn.cursor()
        cursor.execute("SELECT registro_usuario FROM usuarios WHERE nick = %s", (criador,))
        result = cursor.fetchone()
        if result:
            criador_id = result[0]
        cursor.close()
        conn.close()


        
        if titulo and descricao and endereco and cep and data and horario and file and preco and allowed_file(file.filename):

            filename = secure_filename(file.filename)
            filepath = os.path.join(app.config['UPLOAD_FOLDER'], filename)
            file.save(filepath)
            print(f'Saving file to: {filepath}')
            file.save(filepath)
            print('File saved successfully.')


            try:
                conn = get_db_connection()
                cursor = conn.cursor()
                cursor.execute("INSERT INTO eventos (registro_usuario, nome_evento, descricao, endereco, cep, data_evento, horario_evento, imagem, preco, criado_por)"
                                "VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s)",
                                 (criador_id, titulo, descricao, endereco, cep, data, horario, filename, preco, criador))
                conn.commit()
                flash('Evento criado com sucesso!', 'success')
                return redirect(url_for('index'))
            except mysql.connector.Error as err:
                flash(f'Erro ao criar evento: {err}', 'danger')
            finally:
                cursor.close()
                conn.close()
        else:
            flash('Por favor, preencha todos os campos!', 'warning')
    
    return render_template('criar_evento.html')



@app.route('/evento/<int:registro_evento>')
def evento(registro_evento):
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)
    
    cursor.execute("SELECT registro_evento, nome_evento, descricao, endereco, DATE_FORMAT(data_evento, '%d/%m/%Y') AS data_formatada, horario_evento, preco, imagem, criado_por FROM eventos WHERE registro_evento = %s", (registro_evento,))
    evento = cursor.fetchone()
    
    cursor.execute("SELECT AVG(nota) as media_avaliacao FROM avaliacoes WHERE registro_evento = %s", (registro_evento,))
    media_avaliacao_result = cursor.fetchone()
    
    cursor.close()
    conn.close()
    
    if evento:
        media_avaliacao = media_avaliacao_result['media_avaliacao'] if media_avaliacao_result and media_avaliacao_result['media_avaliacao'] is not None else 0
        return render_template('evento.html', evento=evento, media_avaliacao=media_avaliacao)
    else:
        flash('Evento não encontrado.', 'danger')
        return redirect(url_for('index'))



@app.route('/avaliar/<int:registro_evento>', methods=['POST'])
def avaliar(registro_evento):
    if not esta_autenticado():
        flash('Você precisa fazer login para avaliar um evento.', 'warning')
        return redirect(url_for('login'))

    nota = request.form['nota']
    usuario = session['usuario']

    try:
        conn = get_db_connection()
        cursor = conn.cursor()

        # Obter o ID do usuário
        cursor.execute("SELECT registro_usuario FROM usuarios WHERE nick = %s", (usuario,))
        registro_usuario = cursor.fetchone()[0]

        # Inserir ou atualizar a avaliação
        cursor.execute("""
            INSERT INTO avaliacoes (registro_usuario, registro_evento, nota)
            VALUES (%s, %s, %s)
            ON DUPLICATE KEY UPDATE nota = VALUES(nota)
        """, (registro_usuario, registro_evento, nota))

        conn.commit()
        flash('Avaliação salva com sucesso!', 'success')
    except mysql.connector.Error as err:
        flash(f'Erro ao salvar avaliação: {err}', 'danger')
    finally:
        cursor.close()
        conn.close()

    return redirect(url_for('evento', registro_evento=registro_evento))







# Função para verificar as credenciais do usuário no banco de dados
def verificar_credenciais(nick, password):
    conn = get_db_connection()
    cursor = conn.cursor()
    cursor.execute("SELECT password_hash FROM usuarios WHERE nick = %s", (nick,))
    result = cursor.fetchone()

    if result is None:
        cursor.close()
        conn.close()
        return False
    
    stored_password_hash = result[0]
    cursor.close()
    conn.close()
    return check_password_hash(stored_password_hash, password)

@app.route('/eventos_passados')
def eventos_passados():
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)
    cursor.execute("SELECT * FROM eventos_passados ORDER BY data_evento DESC")
    eventos_passados = cursor.fetchall()
    cursor.close()
    conn.close()
    return render_template('eventos_passados.html', eventos_passados=eventos_passados)

# Conectar ao banco de dados
conn = get_db_connection()
cursor = conn.cursor(dictionary=True)

# Verificar eventos passados
today = date.today()
cursor.execute("SELECT * FROM eventos WHERE data_evento < %s", (today,))
eventos_passados = cursor.fetchall()

# Mover eventos para a tabela de eventos passados
for evento in eventos_passados:
    try:
        cursor.execute("INSERT INTO eventos_passados (nome_evento, descricao, endereco, data_evento, horario_evento, preco, imagem, criado_por) VALUES (%s, %s, %s, %s, %s, %s, %s, %s)",
                       (evento['nome_evento'], evento['descricao'], evento['endereco'], evento['data_evento'], evento['horario_evento'], evento['preco'], evento['imagem'], evento['criado_por']))
        cursor.execute("DELETE FROM avaliacoes WHERE registro_evento = %s", (evento['registro_evento'],))
        cursor.execute("DELETE FROM eventos WHERE registro_evento = %s", (evento['registro_evento'],))
        conn.commit()
    except mysql.connector.Error as err:
        flash(f'Erro ao mover evento para eventos passados: {err}', 'danger')

# Fechar conexão com o banco de dados
cursor.close()
conn.close()



if __name__ == '__main__':
    if not os.path.exists(app.config['UPLOAD_FOLDER']):
        os.makedirs(app.config['UPLOAD_FOLDER'])
    app.run(debug=True)

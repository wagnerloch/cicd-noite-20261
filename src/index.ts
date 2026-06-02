import express, { Request, Response } from 'express';

const app = express();
const port = process.env.PORT || 3000;

app.get('/', (req: Request, res: Response) => {
    res.send('Olá mundo! Deploy automático com CI/CD! Agora sim, tudo certo! Fluxo completo de CI/CD funcionando perfeitamente! Parabéns, você conseguiu configurar tudo direitinho! Agora é só aproveitar os benefícios do CI/CD e continuar desenvolvendo suas aplicações com mais agilidade e qualidade! 🚀');
});

app.listen(port, () => {
    console.log(`Server is running at http://localhost:${port}`);
});
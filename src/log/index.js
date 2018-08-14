import { createLogger, format, transports } from 'winston';

const { Console } = transports;

const config = {
  format: format.combine(
    format.colorize(),
    format.timestamp(),
    format.printf(info => `[${info.timestamp}] ${info.level}: ${info.message}`),
  ),
  transports: [new Console()],
  exceptionHandlers: [new Console()],
  exitOnError: false,
};

export default createLogger(config);

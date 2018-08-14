import log from './log';

/**
 * Responds to any HTTP request that can provide a "message" field in the body.
 *
 * @param {Object} req ExpressJS object containing the received HTTP request.
 * @param {Object} res ExpressJS object containing the HTTP response to send.
 */
exports.helloWorld = (req, res) => {
  if (req.body.message === undefined) {
    // This is an error case, as "message" is required
    res.status(400).send('No message defined!');
  } else {
    // Everything is ok - call request-terminating method to signal function
    // completion. (Otherwise, the function may continue to run until timeout.)
    log.info(req.body.message);
    res.status(200).end();
  }
};

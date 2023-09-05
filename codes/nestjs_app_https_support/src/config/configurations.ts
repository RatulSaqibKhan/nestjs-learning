export default () => ({
  certificates: {
    keyPath: process.env.CERTIFICATE_KEY_PATH || '',
    certPath: process.env.CERTIFICATE_CERT_PATH || '',
  },
});

$(function() {
   jsxc.init({
      loginForm: {
         form: '#form',
         jid: '#username',
         pass: '#password'
      },
      logoutElement: $('#logout'),
      checkFlash: false,
      rosterAppend: 'body',
      //to: 25,
      keepalive: 25000,
      //timeout: 2500,
      //loginTimeout: 1000 * 60 * 10,
      root: '/webclient/',
      //turnCredentialsPath: '/ajax/getturncredentials.json',
      displayRosterMinimized: function() {
         return true;
      },
      otr: {
         debug: true,
         SEND_WHITESPACE_TAG: true,
         WHITESPACE_START_AKE: true
      },
      loadSettings: function(username, password) {
         return {
            xmpp: {
               url: 'http://helperchat.com:5280/http-bind/',
               domain: 'public.helperchat.com',
               resource: 'web-client',
               overwrite: true,
               onlogin: true
            }
         };
      }
   });

   $(document).on('ready.roster.jsxc', function(){
      $('#content').css('right', $('#jsxc_roster').outerWidth() + parseFloat($('#jsxc_roster').css('right')));
   });
   $(document).on('toggle.roster.jsxc', function(event, state, duration){
      $('#content').animate({
         right: ((state === 'shown') ? $('#jsxc_roster').outerWidth() : 0) + 'px'
      }, duration);
   });
});
    <div class="row">
      <footer class="col-sm-12">
        <div class="col-sm-3 center-block">
            <ul>
              <li class="footer_title">informaci&oacute;n</li>
              <li class="footer_text"><br/></li>
              <li class="footer_text"><a href="https://github.com/PedroBlanco/central-proyectoASIR">web del proyecto</a></li>
              <li class="footer_text">manual de usuario</li><!-- TODO -->
              <li class="footer_text"><a href="https://github.com/PedroBlanco/scorm-encuesta">github</a> / <a href="https://waffle.io/pedroblanco/central-proyectoasir">waffle.io</a></li>
              <li class="footer_text">licencia</li><!-- TODO -->
              <li class="footer_text"><br/></li>
              <li class="footer_text" style="font-style: italic;">&copy; Pedro Blanco Wasmer 2015 - Proyecto Integrado Mayo 2015 para I.E.S. Gran Capitán</li>
            </ul>
        </div>
      </footer>
    </div>
  </div> <!-- *** /container *** -->
  <script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
  <script>window.jQuery || document.write('<script src="js/vendor/jquery-1.11.2.min.js"><\/script>')</script>

  <script src="js/vendor/bootstrap.min.js"></script>

  <!-- Vamos a intentar utilizar jquery-ui -->
  <script src="js/vendor/jquery-ui.min.js"></script>

  <!-- https://github.com/ifightcrime/bootstrap-growl para mostra alerts superpuestas -->
  <script src="js/vendor/jquery.bootstrap-growl.js"></script>

  <!-- Vamos a utilizar https://github.com/marcuswestin/store.js para localStorage -->
  <script src="js/vendor/store.min.js"></script>

  <script src="js/main.js"></script>

  {if $estado_pagina eq 2}
    <script src="js/definir_preguntas.js"></script>
  {/if}
</body>
</html>

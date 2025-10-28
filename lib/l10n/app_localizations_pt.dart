// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get appTitle => 'Cocus Notas';

  @override
  String get notesTitle => 'Minhas Notas';

  @override
  String get newNote => 'Nova Nota';

  @override
  String get editNote => 'Editar Nota';

  @override
  String get title => 'Título';

  @override
  String get close => 'Fechar';

  @override
  String get linkedNotes => 'Notas vinculadas';

  @override
  String get emptyNotes => 'Nenhuma nota ainda';

  @override
  String get save => 'Salvar';

  @override
  String get cancel => 'Cancelar';

  @override
  String get delete => 'Excluir';

  @override
  String get deleteNoteQuestion => 'Excluir Nota?';

  @override
  String deleteNoteConfirm(String noteTitle) {
    return 'Tem certeza de que deseja excluir a nota \"$noteTitle\"?';
  }

  @override
  String get updatedAtLabel => 'Atualizado em';

  @override
  String get search => 'Buscar';

  @override
  String get sort => 'Ordenar';

  @override
  String get sortTitleAsc => 'Título (A-Z)';

  @override
  String get sortTitleDesc => 'Título (Z-A)';

  @override
  String get sortCreatedAsc => 'Data de criação ↑';

  @override
  String get sortCreatedDesc => 'Data de criação ↓';

  @override
  String get sortUpdatedAsc => 'Última edição ↑';

  @override
  String get sortUpdatedDesc => 'Última edição ↓';

  @override
  String get addImage => 'Adicionar Imagem';

  @override
  String get linkNotes => 'Vincular Notas';

  @override
  String get markdownHint => 'Conteúdo (Markdown)';

  @override
  String get noTitle => '(Sem título)';

  @override
  String lastUpdated(Object date) {
    return 'Atualizado em $date';
  }

  @override
  String get noteNotFound => 'Nota não encontrada';

  @override
  String get backToList => 'Lista';

  @override
  String get attachments => 'Anexos';

  @override
  String get exportPDF => 'Exportar para PDF';

  @override
  String get deleteNoteWarning => 'Esta ação não pode ser desfeita.';

  @override
  String goToNote(String noteTitle) {
    return 'Ir para a nota \"$noteTitle\"';
  }
}

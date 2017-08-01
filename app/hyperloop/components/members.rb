class Members < Hyperloop::Router::Component

  render(DIV) do
    MainAppBar()
    Sem.Container(style: { marginTop: '5em' }) {
      # heading
      add_member
      members_table
    }
  end

  def add_member
    button = Sem.Button(icon: true, labelPosition: 'left') {
      Sem.Icon(name: :user)
      "Invite New Member"
    }.as_node

    Sem.Modal(trigger: button.to_n) {
      Sem.ModalHeader { "Invite new Member" }
      Sem.ModalContent {
        Sem.ModalDescription {
          "Enter the email address"

        }
      }
    }

  end

  def heading
    H1 { "Members" }
  end

  def members_table
    Sem.Table(celled: false) {
      Sem.TableHeader {
        Sem.TableRow {
          Sem.TableHeaderCell { "Name" }
          Sem.TableHeaderCell { "Email" }
          Sem.TableHeaderCell {  }
        }
      }
      table_body
    }
  end

  def table_body
    Sem.TableBody {
      Member.each do |member|
        Sem.TableRow {
          Sem.TableCell { "#{member.first_name} #{member.last_name}" }
          Sem.TableCell { member.email }
          Sem.TableCell(textAlign: :right) {
            Sem.Button(icon: true) { Sem.Icon(name: :edit) }
          }
        }
      end
    }
  end

end

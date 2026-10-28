namespace FeatureExplore.FeatureExplore;
using Microsoft.Sales.Customer;

page 50115 "FilterPageBuilder Test"
{
    ApplicationArea = All;
    Caption = 'FilterPageBuilder Test';
    PageType = List;
    UsageCategory = Documents;
    SourceTable = Customer;
    Editable = false;
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                Caption = 'General';
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the number of the customer. The field is either filled automatically from a defined number series, or you enter the number manually because you have enabled manual number entry in the number-series setup.';
                }
                field(Name; Rec.Name)
                {
                    ToolTip = 'Specifies the name of the customer.';
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Filter Customer")
            {
                trigger OnAction()
                var
                    FilterPageBuilder: FilterPageBuilder;
                    Customer: Record Customer;
                begin
                    Customer.SetFilter("No.", '10000|20000');

                    FilterPageBuilder.AddTable(Customer.TableCaption, Database::Customer);
                    FilterPageBuilder.AddRecord(Customer.TableCaption, Customer);
                    FilterPageBuilder.AddField(Customer.TableCaption, Customer."No.", Customer.GetFilter("No."));
                    if FilterPageBuilder.RunModal() then begin

                        Customer.SetView(FilterPageBuilder.GetView(Customer.TableCaption));
                        if Customer.FindSet() then
                            Rec.Copy(Customer);
                    end;
                end;
            }
        }
    }
}

contract('FinancialInstitutions', function(accounts)
{
  it("Init FIs", function(done) {
    var meta = FinancialInstitutions.deployed();

    meta.createFinancialInstitution.call("WBC", "Westpac", "123 Kent St, Sydney, Australia").then(function(fi) {
      assert.isDefined(fi, "FI was not returned");
      assert.equal(fi.getBICFI(), "WBC");
    }).then(done).catch(done);
    done();
  });
});
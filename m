From: Michal Simek <michal.simek@xilinx.com>
Subject: Re: [PATCH v1 3/4] spi/xilinx: Simplify irq allocation
Date: Tue, 9 Jul 2013 16:53:25 +0200
Message-ID: <cab4ad33-0aee-4bc4-be36-6610f19c403d@AM1EHSMHS015.ehs.local>
References: <ff70173bee5f9223ffea2b92b903b4e46ef8b323.1373290150.git.michal.simek@xilinx.com> <b4458c93742bd9dfe69e3553cf377a703c945f81.1373290150.git.michal.simek@xilinx.com> <20130708144930.GG27646@sirena.org.uk> <51DADF3E.1000802@monstr.eu> <20130708162642.GM27646@sirena.org.uk> <51DC1AF1.3090401@monstr.eu> <20130709144704.GY27646@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="----enig2CPXEQERUWJVTAQBQSBFQ"
Cc: Michal Simek <monstr@monstr.eu>,
	Michal Simek <michal.simek@xilinx.com>,
	<linux-kernel@vger.kernel.org>,
	linux-spi <linux-spi@vger.kernel.org>,
	Grant Likely <grant.likely@linaro.org>,
	<spi-devel-general@lists.sourceforge.net>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130709144704.GY27646@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

------enig2CPXEQERUWJVTAQBQSBFQ
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 07/09/2013 04:47 PM, Mark Brown wrote:
> On Tue, Jul 09, 2013 at 04:15:13PM +0200, Michal Simek wrote:
> =

>> 4. spi_master_release()
>> 5. devres_release() with irq
> =

>> If interrupt happends between 4 and 5 than it can be the problem.
>> Do I understand you correctly?
> =

> Yes.

great.

> =

>> If this is problematic case we can disable local and global interrupts
>> and add it between 2 and 3 or 3-4.
>> 	/* Disable all the interrupts just in case */
>> 	xspi->write_fn(0, regs_base + XIPIF_V123B_IIER_OFFSET);
>> 	/* Disable the global IPIF interrupt */
>> 	xspi->write_fn(0, regs_base + XIPIF_V123B_DGIER_OFFSET);
> =

>> What do you think about this solution?
> =

> That's fine, though if just manually freeing the IRQ works that's also
> OK...

yeah.


>> I have also tried to run one thing with and without this patch
>> and the results are below.
> =

>> When I add this irq disable function between 1 and 2 then
>> module removing stucks.
> =

> You'll need to wait until the device is quiesced at least if it's
> relying on the interrupt to complete operations.
> =


ok. Will send v2 of this patch.

Thanks,
Michal


------enig2CPXEQERUWJVTAQBQSBFQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlHcI+UACgkQykllyylKDCHHcQCePC7ImYcQwBUODfLFTpgeZOz6
ciMAmQEFccuRrgh3/vEQXW7vloz4K0Gh
=ktlc
-----END PGP SIGNATURE-----


------enig2CPXEQERUWJVTAQBQSBFQ--

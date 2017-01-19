From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: [PATCH v2 2/3] spi: pxa2xx: Prepare for edge-triggered interrupts
Date: Thu, 19 Jan 2017 16:34:31 +0100
Message-ID: <7e5fb21d-35bd-6ac3-9e6f-cffed656997f@siemens.com>
References: <cover.1484592296.git.jan.kiszka@siemens.com>
 <cover.1484592296.git.jan.kiszka@siemens.com>
 <7b15a0910a3ad861fd32161c72559bafa7b71e29.1484592296.git.jan.kiszka@siemens.com>
 <87ziiqdstr.fsf@belgarion.home>
 <4d97e416-4d32-3b9f-0695-de116a4b26bd@siemens.com>
 <87r340eq28.fsf@belgarion.home>
 <b3e0d393-b841-1556-ddd2-5634f12b6f2c@siemens.com>
 <20170118124645.6ugjwbfeq5vsh2to@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3819604222010403675=="
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
 linux-kernel@vger.kernel.org, Haojian Zhuang <haojian.zhuang@gmail.com>,
 linux-spi@vger.kernel.org, Jarkko Nikula <jarkko.nikula@linux.intel.com>,
 linux-arm-kernel@lists.infradead.org,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Robert Jarzmik <robert.jarzmik@free.fr>,
 Sascha Weisenberger <sascha.weisenberger@siemens.com>,
 Daniel Mack <daniel@zonque.org>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170118124645.6ugjwbfeq5vsh2to@sirena.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============3819604222010403675==
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="4Qv9bgGvkTnlK3ApvA594fm3Pnm7sw1Le"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--4Qv9bgGvkTnlK3ApvA594fm3Pnm7sw1Le
Content-Type: multipart/mixed; boundary="jGvsd5lo2euMXVm3DMJQc198Nwh4kSEXn";
 protected-headers="v1"
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Mark Brown <broonie@kernel.org>
Cc: Robert Jarzmik <robert.jarzmik@free.fr>, linux-spi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Daniel Mack <daniel@zonque.org>,
 Haojian Zhuang <haojian.zhuang@gmail.com>, linux-kernel@vger.kernel.org,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Jarkko Nikula <jarkko.nikula@linux.intel.com>,
 Sascha Weisenberger <sascha.weisenberger@siemens.com>
Message-ID: <7e5fb21d-35bd-6ac3-9e6f-cffed656997f@siemens.com>
Subject: Re: [PATCH v2 2/3] spi: pxa2xx: Prepare for edge-triggered interrupts
References: <cover.1484592296.git.jan.kiszka@siemens.com>
 <cover.1484592296.git.jan.kiszka@siemens.com>
 <7b15a0910a3ad861fd32161c72559bafa7b71e29.1484592296.git.jan.kiszka@siemens.com>
 <87ziiqdstr.fsf@belgarion.home>
 <4d97e416-4d32-3b9f-0695-de116a4b26bd@siemens.com>
 <87r340eq28.fsf@belgarion.home>
 <b3e0d393-b841-1556-ddd2-5634f12b6f2c@siemens.com>
 <20170118124645.6ugjwbfeq5vsh2to@sirena.org.uk>
In-Reply-To: <20170118124645.6ugjwbfeq5vsh2to@sirena.org.uk>

--jGvsd5lo2euMXVm3DMJQc198Nwh4kSEXn
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 2017-01-18 13:46, Mark Brown wrote:
> On Wed, Jan 18, 2017 at 10:33:07AM +0100, Jan Kiszka wrote:
>> On 2017-01-18 09:21, Robert Jarzmik wrote:
>=20
>>>>>> +	while (1) {
>=20
>>>>> This bit worries me a bit, as this can be either :
>>>>>  - hogging the SoC's CPU, endlessly running
>>>>>  - or even worse, blocking the CPU for ever
>=20
>>>>> The question behind is, should this be done in a top-half, or moved=
 to a irq
>>>>> thread ?
>=20
>>>> Every device with a broken interrupt source can hog CPUs, nothing
>>>> special with this one. If you don't close the loop in the handler
>>>> itself, you close it over the hardware retriggering the interrupt ov=
er
>>>> and over again.
>=20
>>> I'm not speaking of a broken interrupt source, I'm speaking of a brok=
en code,
>>> such as in the handler, or broken status readback, or lack of underst=
anding on
>>> the status register which may imply the while(1) to loop forever.
>=20
>>>> So, I don't see a point in offloading to a thread. The normal case i=
s
>>>> some TX done (FIFO available) event followed by an RX event, then th=
e
>>>> transfer is complete, isn't it?
>=20
>>> The point is if you stay forever in the while(1) loop, you can at lea=
st have a
>>> print a backtrace (LOCKUP_DETECTOR).
>=20
>> I won't consider "debugability" as a good reason to move interrupt
>> handlers into threads. There should be real workload that requires
>> offloading or specific prioritization.
>=20
> It's failure mitigation - you're translating a hard lockup into
> something that will potentially allow the system to soldier on which is=

> likely to be less severe for the user as well as making things easier t=
o
> figure out.  If we're doing something like this I'd at least have a
> limit on how long we allow the interrupt to scream.
>=20

OK, OK, if that is the biggest worry, I can change the pattern from
loop-based to SCCR1-based, i.e. mask all interrupt sources once per
interrupt so that we enforce a falling edge. Fine.

But now I'm looking at the driver, wondering who all is fiddling under
which conditions with SCCR1. There are a lot of RMW patterns, but I do
not see the locking pattern behind that. Are all RMW accesses run only
in the interrupt handler context? Unlikely, at least with the dmaengine
in the loop.

Closing my eyes regarding this potential issue for now, the patch could
become as simple as

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 0d10090..f9c2329 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -785,6 +785,9 @@ static irqreturn_t ssp_int(int irq, void *dev_id)
 	if (!(status & mask))
 		return IRQ_NONE;
=20
+	pxa2xx_spi_write(drv_data, SSCR1, sccr1_reg & ~drv_data->int_cr1);
+	pxa2xx_spi_write(drv_data, SSCR1, sccr1_reg);
+
 	if (!drv_data->master->cur_msg) {
 		handle_bad_msg(drv_data);
 		/* Never fail */

Not efficient /wrt register accesses, but that's apparently not yet
a design goal anyway (I stumbled over the SSCR1 locking while
considering to introduce a cache for that reg).

Jan

--=20
Siemens AG, Corporate Technology, CT RDA ITP SES-DE
Corporate Competence Center Embedded Linux


--jGvsd5lo2euMXVm3DMJQc198Nwh4kSEXn--

--4Qv9bgGvkTnlK3ApvA594fm3Pnm7sw1Le
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAliA3IgACgkQitSsb3rl5xR1ugCdH29+6CSdQT3ifwOWMmjtF6LH
CH0AoOJZ7B6hVpmeQHEdClQHIKdIh2NX
=/FsF
-----END PGP SIGNATURE-----

--4Qv9bgGvkTnlK3ApvA594fm3Pnm7sw1Le--


--===============3819604222010403675==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============3819604222010403675==--

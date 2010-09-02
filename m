From: Hu Mingkai-B21284 <B21284@freescale.com>
Subject: RE: [PATCH v2 1/6] spi/mpc8xxx: refactor the common code for SPI/eSPI
	controller
Date: Thu, 2 Sep 2010 16:27:38 +0800
Message-ID: <73839B4A0818E747864426270AC332C30561B6CF@zmy16exm20.fsl.freescale.net>
References: <1280735524-17547-1-git-send-email-Mingkai.hu@freescale.com>
	<1280735524-17547-2-git-send-email-Mingkai.hu@freescale.com>
	<AANLkTim=Qc-zA=9E0SfOB+8V48Y957MXkefD324xoq0w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: linuxppc-dev@ozlabs.org, Gala Kumar-B11780 <B11780@freescale.com>,
	Zang Roy-R61911 <R61911@freescale.com>,
	spi-devel-general@lists.sourceforge.net
To: "Grant Likely" <grant.likely@secretlab.ca>
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
Content-Class: urn:content-classes:message
In-Reply-To: <AANLkTim=Qc-zA=9E0SfOB+8V48Y957MXkefD324xoq0w@mail.gmail.com>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Sender: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
List-Id: linux-spi.vger.kernel.org

Hi Grant and all,

Sorry for the delay, I'm on business trip some weeks ago.

> -----Original Message-----
> From: glikely@secretlab.ca [mailto:glikely@secretlab.ca] On Behalf Of Gra=
nt
> Likely
> Sent: Tuesday, August 10, 2010 2:40 PM
> To: Hu Mingkai-B21284
> Cc: linuxppc-dev@ozlabs.org; spi-devel-general@lists.sourceforge.net; Gala
> Kumar-B11780; Zang Roy-R61911
> Subject: Re: [PATCH v2 1/6] spi/mpc8xxx: refactor the common code for SPI=
/eSPI
> controller
> =

> On Mon, Aug 2, 2010 at 1:51 AM, Mingkai Hu <Mingkai.hu@freescale.com> wro=
te:
> > Refactor the common code in file spi_mpc8xxx.c to spi_fsl_lib.c used
> > by SPI/eSPI controller driver as a library, move the SPI controller
> > driver to a new file spi_fsl_spi.c, and leave the QE/CPM SPI
> > controller code in this file.
> >
> > Because the register map of the SPI controller and eSPI controller is
> > so different, also leave the code operated the register to the driver
> > code, not the common code.
> >
> > Signed-off-by: Mingkai Hu <Mingkai.hu@freescale.com>
> > ---
> > v2:
> > =A0- Rename spi_mpc8xxx.c to spi_fsl_lib.c, also the config name
> > =A0- Rename fsl_spi.c to spi_fsl_spi.c, also the config name
> > =A0- Move register map definiton from spi_fsl_lib.c to spi_fsl_spi.c
> > =A0- Break some funcions line in the arguments instead of the
> > declaration
> > =A0- Init bits_per_word to 0 to eliminate the else clause
> > =A0- Add brace for the else clause to match if clause
> > =A0- Drop the last entry's comma in the match table
> > =A0- move module_init() immediately after the init fsl_spi_init()
> > function
> >
> > =A0drivers/spi/Kconfig =A0 =A0 =A0 | =A0 20 +-
> > =A0drivers/spi/Makefile =A0 =A0 =A0| =A0 =A03 +-
> > =A0drivers/spi/spi_fsl_lib.c | =A0237 ++++++++
> > =A0drivers/spi/spi_fsl_lib.h | =A0119 ++++
> > =A0drivers/spi/spi_fsl_spi.c | 1173
> > +++++++++++++++++++++++++++++++++++++
> > =A0drivers/spi/spi_mpc8xxx.c | 1421
> > ---------------------------------------------
> =

> This patch seems pretty good now.  However, the rename from spi_mpc8xxx.c=
 to
> spi_fsl_lib.c should be done in a separate patch.  It is too difficult to=
 track
> what has changed, when the file gets moved at the same time.  Move the fi=
le in
> one patch verbatim (with the required Makefile change), and then move out=
 the
> fsl_spi specific bits in a second patch.
> =


Ok, I'll spilt this patch.

Thanks,
Mingkai

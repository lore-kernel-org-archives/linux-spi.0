From: raffaele.recalcati@bticino.it
Subject: Rif: Re: [PATCH] spi: davinci: Added support for chip select using
	gpio
Date: Thu, 1 Jul 2010 07:59:51 +0200
Message-ID: <OF309AC560.325C057E-ONC1257753.0020F1E5-C1257753.0020F21E@grpleg.it>
References: <1277707655-3468-1-git-send-email-lamiaposta71@gmail.com>,
	<AANLkTilnVxNfsfJ4nCWITM_DhOb6BDGZQC8cMiM0RkiF@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: linux-arm-kernel@lists.infradead.org,
	davinci-linux-open-source@linux.davincidsp.com,
	David Brownell <dbrownell@users.sourceforge.net>,
	Russell King <linux@arm.linux.org.uk>,
	Thomas Koeller <thomas.koeller@baslerweb.com>,
	Sudhakar Rajashekhara <sudhakar.raj@ti.com>,
	linux-kernel@vger.kernel.org, Sandeep Paulraj <s-paulraj@ti.com>,
	Davide Bonfanti <davide.bonfanti@bticino.it>,
	Philby John <pjohn@in.mvista.com>,
	Miguel Aguilar <miguel.aguilar@ridgerun.com>,
	Cyril Chemparathy <cyril@ti.com>, spi-devel-general@lists.sourceforge.net,
	Raffaele Recalcati <lamiaposta71@gmail.com>
To: Grant Likely <grant.likely@secretlab.ca>,
	Brian Niebuhr <bniebuhr3@gmail.com>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <AANLkTilnVxNfsfJ4nCWITM_DhOb6BDGZQC8cMiM0RkiF@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org


-----glikely@secretlab.ca ha scritto: -----

>Per:=A0Raffaele=A0Recalcati=A0<lamiaposta71@gmail.com>,=A0Brian=A0Niebuhr
><bniebuhr3@gmail.com>
>Da:=A0Grant=A0Likely=A0<grant.likely@secretlab.ca>
>Inviato=A0da:=A0glikely@secretlab.ca
>Data:=A001/07/2010=A001.03
>Cc:=A0davinci-linux-open-source@linux.davincidsp.com,=A0Raffaele
>Recalcati=A0<raffaele.recalcati@bticino.it>,=A0Davide=A0Bonfanti
><davide.bonfanti@bticino.it>,=A0Russell=A0King=A0<linux@arm.linux.org.uk>,
>Sandeep=A0Paulraj=A0<s-paulraj@ti.com>,=A0Cyril=A0Chemparathy=A0<cyril@ti.=
com>,
>Miguel=A0Aguilar=A0<miguel.aguilar@ridgerun.com>,=A0Thomas=A0Koeller
><thomas.koeller@baslerweb.com>,=A0David=A0Brownell
><dbrownell@users.sourceforge.net>,=A0Philby=A0John=A0<pjohn@in.mvista.com>,
>Sudhakar=A0Rajashekhara=A0<sudhakar.raj@ti.com>,
>linux-arm-kernel@lists.infradead.org,=A0linux-kernel@vger.kernel.org,
>spi-devel-general@lists.sourceforge.net
>Oggetto:=A0Re:=A0[PATCH]=A0spi:=A0davinci:=A0Added=A0support=A0for=A0chip=
=A0select
>using=A0gpio
>
>On=A0Mon,=A0Jun=A028,=A02010=A0at=A012:47=A0AM,=A0Raffaele=A0Recalcati
><lamiaposta71@gmail.com>=A0wrote:
>>=A0From:=A0Raffaele=A0Recalcati=A0<raffaele.recalcati@bticino.it>
>>
>>=A0=A0=A0=A0It=A0is=A0not=A0everytime=A0possible,=A0due=A0to=A0hardware=
=A0constraints,
>>=A0=A0=A0=A0to=A0use=A0the=A0hw=A0chip=A0select=A0available=A0on=A0spi=A0=
port.
>>=A0=A0=A0=A0So=A0I=A0add=A0this=A0possibility=A0using=A0a=A0gpio=A0as=A0c=
hip=A0select.
>>=A0=A0=A0=A0If=A0controller_data=A0variable=A0is=A0not=A0null=A0it=A0is
>>=A0=A0=A0=A0the=A0gpio=A0to=A0be=A0used=A0as=A0chip=A0select.
>>=A0=A0=A0=A0The=A0default=A0case=A0is=A0compatible=A0with=A0evmdm365.
>>=A0=A0=A0=A0This=A0patch=A0has=A0been=A0developed=A0against=A0the
>>
>http://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-davinci.
>git
>>=A0=A0=A0=A0git=A0tree=A0and=A0has=A0been=A0tested=A0on=A0bmx=A0board=A0(=
similar=A0to=A0dm365=A0evm
>but=A0with
>>=A0=A0=A0=A0gpio=A0as=A0spi=A0chip=A0select).
>>
>>=A0Signed-off-by:=A0Raffaele=A0Recalcati=A0<raffaele.recalcati@bticino.it>
>>=A0Signed-off-by:=A0Davide=A0Bonfanti=A0<davide.bonfanti@bticino.it>
>
>The=A0davinci=A0SPI=A0driver=A0is=A0getting=A0completely=A0replaced=A0(as=
=A0soon=A0as=A0I
>receive=A0the=A0respun=A0patches),=A0and=A0I=A0assume=A0this=A0patch=A0wil=
l=A0no=A0longer
>apply=A0after=A0the=A0fact,=A0so=A0I'm=A0not=A0going=A0to=A0pick=A0this=A0=
patch=A0up.=A0=A0You
>should=A0coordinate=A0with=A0Brian=A0Niebuhr=A0to=A0get=A0this=A0feature=
=A0into=A0his=A0new
>driver.

I'm not very lucky with davinci-linux-open-source patching.
Thank you for the information.
The patch is really simple and so it will be not a real problem to up port
it.

I'd like anyway a timing roadmap, because,
if now the best kernel choose for dm365 is surely
http://arago-project.org/git/projects/linux-davinci.git
because of dvsdk (video codec) compatibility,
it is possible that next year 2.6.36 will be stable and compatible to dvsdk
(video codec).
The kernel of dm365 (that is a video processor) has to be compatible to its
video codec.
How to manage the transition?


>Cheers,
>g.
>
>>=A0---
>>=A0=A0arch/arm/mach-davinci/dm365.c=A0|=A0=A0=A010=A0++++++----
>>=A0=A0drivers/spi/davinci_spi.c=A0=A0=A0=A0=A0|=A0=A0=A027=A0++++++++++++=
++++++---------
>>=A0=A02=A0files=A0changed,=A024=A0insertions(+),=A013=A0deletions(-)
>>
>>=A0diff=A0--git=A0a/arch/arm/mach-davinci/dm365.c
>b/arch/arm/mach-davinci/dm365.c
>>=A0index=A0a146849..42fd4a4=A0100644
>>=A0---=A0a/arch/arm/mach-davinci/dm365.c
>>=A0+++=A0b/arch/arm/mach-davinci/dm365.c
>>=A0@@=A0-677,10=A0+677,12=A0@@=A0void=A0__init=A0dm365_init_spi0(unsigned
>chipselect_mask,
>>=A0=A0=A0=A0=A0=A0=A0=A0davinci_cfg_reg(DM365_SPI0_SDO);
>>
>>=A0=A0=A0=A0=A0=A0=A0=A0/*=A0not=A0all=A0slaves=A0will=A0be=A0wired=A0up=
=A0*/
>>=A0-=A0=A0=A0=A0=A0=A0=A0if=A0(chipselect_mask=A0&=A0BIT(0))
>>=A0-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0davinci_cfg_reg(DM365_SP=
I0_SDENA0);
>>=A0-=A0=A0=A0=A0=A0=A0=A0if=A0(chipselect_mask=A0&=A0BIT(1))
>>=A0-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0davinci_cfg_reg(DM365_SP=
I0_SDENA1);
>>=A0+=A0=A0=A0=A0=A0=A0=A0if=A0=A0(!((unsigned=A0long)=A0info->controller_=
data))=A0{
>>=A0+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0if=A0(chipselect_mask=A0=
&=A0BIT(0))
>>=A0+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
davinci_cfg_reg(DM365_SPI0_SDENA0);
>>=A0+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0if=A0(chipselect_mask=A0=
&=A0BIT(1))
>>=A0+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
davinci_cfg_reg(DM365_SPI0_SDENA1);
>>=A0+=A0=A0=A0=A0=A0=A0=A0}
>>
>>=A0=A0=A0=A0=A0=A0=A0=A0spi_register_board_info(info,=A0len);
>>
>>=A0diff=A0--git=A0a/drivers/spi/davinci_spi.c=A0b/drivers/spi/davinci_spi=
.c
>>=A0index=A095afb6b..621ae46=A0100644
>>=A0---=A0a/drivers/spi/davinci_spi.c
>>=A0+++=A0b/drivers/spi/davinci_spi.c
>>=A0@@=A0-29,6=A0+29,7=A0@@
>>=A0=A0#include=A0<linux/spi/spi_bitbang.h>
>>=A0=A0#include=A0<linux/slab.h>
>>
>>=A0+#include=A0<mach/gpio.h>
>>=A0=A0#include=A0<mach/spi.h>
>>=A0=A0#include=A0<mach/edma.h>
>>
>>=A0@@=A0-270,18=A0+271,26=A0@@=A0static=A0void=A0davinci_spi_chipselect(s=
truct
>spi_device=A0*spi,=A0int=A0value)
>>=A0=A0=A0=A0=A0=A0=A0=A0pdata=A0=3D=A0davinci_spi->pdata;
>>
>>=A0=A0=A0=A0=A0=A0=A0=A0/*
>>=A0-=A0=A0=A0=A0=A0=A0=A0=A0*=A0Board=A0specific=A0chip=A0select=A0logic=
=A0decides=A0the=A0polarity
>and=A0cs
>>=A0-=A0=A0=A0=A0=A0=A0=A0=A0*=A0line=A0for=A0the=A0controller
>>=A0-=A0=A0=A0=A0=A0=A0=A0=A0*/
>>=A0+=A0=A0=A0=A0=A0=A0=A0*=A0Board=A0specific=A0chip=A0select=A0logic=A0d=
ecides=A0the=A0polarity=A0and
>cs
>>=A0+=A0=A0=A0=A0=A0=A0=A0*=A0line=A0for=A0the=A0controller
>>=A0+=A0=A0=A0=A0=A0=A0=A0*/
>>=A0=A0=A0=A0=A0=A0=A0=A0if=A0(value=A0=3D=3D=A0BITBANG_CS_INACTIVE)=A0{
>>=A0-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0set_io_bits(davinci_spi-=
>base=A0+=A0SPIDEF,
>CS_DEFAULT);
>>=A0-
>>=A0-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0data1_reg_val=A0|=3D=A0C=
S_DEFAULT=A0<<=A0SPIDAT1_CSNR_SHIFT;
>>=A0-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0iowrite32(data1_reg_val,=
=A0davinci_spi->base=A0+
>SPIDAT1);
>>=A0-
>>=A0+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0if=A0=A0((unsigned=A0lon=
g)=A0spi->controller_data)=A0{
>>=A0+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
gpio_set_value(spi->controller_data,=A0\
>>=A0+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0!(spi->mode=A0&=A0SPI_CS_HIGH));
>>=A0+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0}=A0else=A0{
>>=A0+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
set_io_bits(davinci_spi->base=A0+=A0SPIDEF,
>CS_DEFAULT);
>>=A0+
>>=A0+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
data1_reg_val=A0|=3D=A0CS_DEFAULT=A0<<
>SPIDAT1_CSNR_SHIFT;
>>=A0+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
iowrite32(data1_reg_val,=A0davinci_spi->base
>+=A0SPIDAT1);
>>=A0+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0}
>>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0while=A0((ioread32(davinc=
i_spi->base=A0+=A0SPIBUF)
>>=A0-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0&=A0SPIBUF_RXEMPTY_MASK)=A0=
=3D=3D
>0)
>>=A0+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0&=A0SPIBUF_RXEMPTY_MASK)=A0=3D=3D=A00)
>>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0c=
pu_relax();
>>=A0+=A0=A0=A0=A0=A0=A0=A0}=A0else=A0{
>>=A0+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0if=A0=A0((unsigned=A0lon=
g)=A0spi->controller_data)
>>=A0+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
gpio_set_value(spi->controller_data,=A0\
>>=A0+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0(spi->mode=A0&=A0SPI_CS_HIGH));
>>=A0=A0=A0=A0=A0=A0=A0=A0}
>>=A0=A0}
>>
>>=A0--
>>=A01.7.0.4
>>
>>
>
>
>
>--
>Grant=A0Likely,=A0B.Sc.,=A0P.Eng.
>Secret=A0Lab=A0Technologies=A0Ltd.

Ce message, ainsi que tous les fichiers joints =E0 ce message,
peuvent contenir des informations sensibles et/ ou confidentielles
ne devant pas =EAtre divulgu=E9es. Si vous n'=EAtes pas le destinataire
de ce message (ou que vous recevez ce message par erreur), nous
vous remercions de le notifier imm=E9diatement =E0 son exp=E9diteur, et
de d=E9truire ce message. Toute copie, divulgation, modification,
utilisation ou diffusion, non autoris=E9e, directe ou indirecte, de
tout ou partie de ce message, est strictement interdite.

This e-mail, and any document attached hereby, may contain
confidential and/or privileged information. If you are not the
intended recipient (or have received this e-mail in error) please
notify the sender immediately and destroy this e-mail. Any
unauthorized, direct or indirect, copying, disclosure, distribution
or other use of the material or parts thereof is strictly
forbidden.

From: Han Xu <han.xu-3arQi8VN3Tc@public.gmane.org>
Subject: RE: [EXT] Re: [PATCH V2 2/5] spi: fspi: dynamically alloc AHB memory
Date: Sat, 15 Feb 2020 16:14:31 +0000
Message-ID: <AM6PR04MB4967BE79DAAC140162B3D22497140@AM6PR04MB4967.eurprd04.prod.outlook.com>
References: <20200202125950.1825013-1-aford173@gmail.com>
 <20200202125950.1825013-2-aford173@gmail.com>
 <CAOMZO5D3emrAk84wDS04qJC-3AyvFnqodhoMsXO-ukHnYsU+PQ@mail.gmail.com>
 <CAHCN7xJyZRwJhnWW2mAbOeGyrMsB7Au_e6AvwiNmNS8gFUfSyw@mail.gmail.com>
 <20200212120753.GF4028@sirena.org.uk>
 <CAHCN7x+5bACfYVX49Lib+fmNq-dEOkcyi0gXt7rtYxrGaYbH1Q@mail.gmail.com>
 <20200213184624.GK4333@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Cc: Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Yogesh Gaur <yogeshgaur.83-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Ashish Kumar <ashish.kumar-3arQi8VN3Tc@public.gmane.org>,
        Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
        Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>,
        Pengutronix Kernel Team <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>,
        dl-linux-imx <linux-imx-3arQi8VN3Tc@public.gmane.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
        <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Adam Ford <aford173-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200213184624.GK4333-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org



> -----Original Message-----
> From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> Sent: Thursday, February 13, 2020 12:46 PM
> To: Adam Ford <aford173-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Cc: Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>; linux-spi <linux-spi-u79uwXL29TasMV2rI37PzA@public.gmane.org=
org>;
> Han Xu <han.xu-3arQi8VN3Tc@public.gmane.org>; Yogesh Gaur <yogeshgaur.83-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>; Ashish
> Kumar <ashish.kumar-3arQi8VN3Tc@public.gmane.org>; Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>; Mark
> Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>; Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>; Sascha
> Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>; Pengutronix Kernel Team
> <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>; dl-linux-imx <linux-imx-3arQi8VN3Tc@public.gmane.org>; open list:OPEN
> FIRMWARE AND FLATTENED DEVICE TREE BINDINGS
> <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>; linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>=
;
> moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE <linux-arm-
> kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
> Subject: [EXT] Re: [PATCH V2 2/5] spi: fspi: dynamically alloc AHB memory
>=20
> On Wed, Feb 12, 2020 at 07:08:49AM -0600, Adam Ford wrote:
>=20
> > The original author was copied on the initial commit.  I literally
> > generated the patch from NXP's branch,  added my notes, and pushed
> > them to the mailing lists after testing them on the  the Linux master
> > branch.   I am a bit disappointed that NXP's author hasn't responded
> > to any of the comments or feedback.  NXP knows their hardware and
>=20
> Bear in mind that it's been the spring festival and there's been quite a =
bit of delay
> in getting back to work in China resulting from coronavirus stuff so hope=
fully it's
> just a delay in replying.

The FSPI is a shared IP with other NXP BU. We are debugging an issue may re=
lated to this patch. I will resend the patch set after the root cause found=
.

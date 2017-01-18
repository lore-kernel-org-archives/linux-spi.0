From: Pandy Gao <pandy.gao-3arQi8VN3Tc@public.gmane.org>
Subject: RE: [Patch V1 2/2] spi: fsl-lpspi: add VLLS mode support
Date: Wed, 18 Jan 2017 03:50:16 +0000
Message-ID: <HE1PR0401MB22823F493AFE1343D061B3AFF67F0@HE1PR0401MB2282.eurprd04.prod.outlook.com>
References: <1483522697-6691-1-git-send-email-pandy.gao@nxp.com>
 <1483522697-6691-2-git-send-email-pandy.gao@nxp.com>
 <20170109193350.aufenjuhtge5e3lu@sirena.org.uk>
 <AM4PR0401MB22737664A5030928464226C7F67C0@AM4PR0401MB2273.eurprd04.prod.outlook.com>
 <20170117190407.p5ad3dz7ixqm4vz6@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Cc: "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170117190407.p5ad3dz7ixqm4vz6-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Content-Language: en-US
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Mark Brown <mailto:broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> Sent: Wednesday, January 18, 2=
017 3:04 AM
> To: Pandy Gao <pandy.gao-3arQi8VN3Tc@public.gmane.org>
> Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Subject: Re: [Patch V1 2/2] spi: fsl-lpspi: add VLLS mode support
>=20
> On Tue, Jan 17, 2017 at 07:03:28AM +0000, Pandy Gao wrote:
>=20
> > > > The patch recovers the pinctrl setting when exit VLLS mode.
>=20
> > > Why is this a change here and not in the pinctrl driver?  It sounds
> > > like it's the pinctrl driver that's forgetting the settings and
> > > should be restoring them on resume but perhaps I'm missing
> something here.
>=20
> > If the pinctrl driver restores the setting on resume, then all device
> > node should be scanned,  which is irregular.
>=20
> What would restoring the configuration have to do with scanning the
> device tree?  The changelog says this is just reapplying the same
> settings we started out with so it's just a case of restoring the state o=
f
> the device after a runtime resume which is a perfectly normal thing for
> a driver to do.

We can reapply  the initial settings as the configurations defined in
device node iomuxc in pinctrl driver.  However, I think there are some
limitations.  For example, conflicts may exist between enet1grp and
ecspi3grp, which is not easy for the pinctrl  driver to find out.

&iomuxc {
	pinctrl_ecspi3: ecspi3grp=20
	{
		...
	};

            	pinctrl_enet1: enet1grp
	 {
		...
	};
}

Best Regards
Gao Pan
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

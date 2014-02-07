From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/2] spi: Add Qualcomm QUP SPI controller support
Date: Fri, 7 Feb 2014 17:18:34 +0000
Message-ID: <20140207171834.GF1757@sirena.org.uk>
References: <1391705868-20091-1-git-send-email-iivanov@mm-sol.com>
 <1391705868-20091-3-git-send-email-iivanov@mm-sol.com>
 <20140207073952.GA2610@qualcomm.com>
 <20140207165127.GV20228@joshc.qualcomm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/aVve/J9H4Wl5yVO"
Cc: Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	"Ivan T. Ivanov" <iivanov-NEYub+7Iv8PQT0dZR+AlfA@public.gmane.org>,
	Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Alok Chauhan <alokc-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	Gilad Avidov <gavidov-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	Kiran Gunda <kgunda-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	Sagar Dharia <sdharia-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	Andy Gross <agross-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
To: Josh Cartwright <joshc-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140207165127.GV20228-OP5zVEFNDbfdOxZ39nK119BPR1lH4CV8@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--/aVve/J9H4Wl5yVO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 07, 2014 at 10:51:27AM -0600, Josh Cartwright wrote:

> 	config SPI_QUP
> 		tristate "Qualcomm SPI Support with QUP interface"
> 		depends on OF
> 		depends on ARM

Does this really depend on ARM?  If so why?

> 		depends on ARCH_MSM_DT || COMPILE_TEST

> With Kumar's pending the ARCH_MSM_DT -> ARCH_QCOM rename, we'll
> introduce a arm-soc/spi tree dependency here that we'll need to keep
> track of.

It seems simpler to just depend on MSM_DT || ARCH_QCOM or whatever.

--/aVve/J9H4Wl5yVO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS9RVmAAoJELSic+t+oim9rNMP/R9suSA2XsORTOdBvvhp3HoM
f/bPIoB6+kfOgnx0Rt2+PPDIP6/uyUURjCf37g/FnPAs6Wlp9wnR17DqgyIq7oyn
qS3S668rYQTHXMfoj5wobkOqHUHuZyGd3qVc421nA3N7b22LR2ib0O6kUeEQR/Qg
jWSTYxhbHuGSQEhprpGjiPaCkyZ+tGorLQ1DP3HjcupQe+FsYXkYFXbwd4oLeqwz
3WyrER1UQsMgoTDl7MDW71El/nOmB6YCUWYeQGcFdOl608utnxsq7RI4U9h7zh+o
21OLwhr0+0Icf1g4Qtvo2y3/cC5fiqjYiKui4I3ppYAiSMHtoagmdIrIj09n+CjH
ql6LB+w8gCVvVjmqHWBya6O0q8ryutFgxh/DgH3Lw42lqu3+qlYHjdi3VKRJSyuW
i/qhT5Gi0K2O6zkwtAkL4lVWm+SXungFxBdK3M8DXt0wnDjeK1ZfRCNAncLEAECZ
qeU7YdWluPJ7efqYRck2PZLAecNdrRujNOFtLBqPSQlrMKtHwi+eWG3fAy3itJW9
QeBGKTOyH9PduZ6wlS6mzDtLuBO+rxzbLnScPEALd9/F08ejrFHOOy3ab1X5Pr0Q
dnXRqueg7UNJviRye/BIZOBh2ogK5I13+gssp4C6AMJH4I3cnpXPnbpcN+xj8f16
yPlCv+guFbOuoFEC0gmX
=iHN6
-----END PGP SIGNATURE-----

--/aVve/J9H4Wl5yVO--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

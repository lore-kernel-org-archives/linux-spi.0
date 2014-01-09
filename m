From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: Check conflicting CS based on spi->chip_select
 instead of device name
Date: Thu, 9 Jan 2014 14:36:04 +0000
Message-ID: <20140109143604.GA12858@sirena.org.uk>
References: <1389273835-8615-1-git-send-email-mika.westerberg@linux.intel.com>
 <20140109140646.GT31886@sirena.org.uk>
 <20140109142729.GA2494@intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yrj/dFKFPuw6o+aM"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140109142729.GA2494-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--yrj/dFKFPuw6o+aM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 09, 2014 at 04:27:29PM +0200, Mika Westerberg wrote:
> On Thu, Jan 09, 2014 at 02:06:46PM +0000, Mark Brown wrote:

> > This actually also points out another issue - if we have two instances
> > of a device on different buses they could end up with the same
> > dev_name() if they have the same chip select.  Hrm.

> I don't think that can happen, at least in case of ACPI, since each ACPI
> device has unique name, such as 'INT33C0:00' - the ':00' suffix is the
> "instance" number ACPI core gives for devices.

That's OK then.

--yrj/dFKFPuw6o+aM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSzrPRAAoJELSic+t+oim9eXYQAJhEN52lnVRzu76+DaQ0lJ/A
rl0Vm2dkHLKulrEUk8+sZEMMzpMVwoX9YZGJCh1KhnhKkzOf7gE/r2IyAP/H88HT
UAVy0bdY/WQDSaFkQae6ad5ek8vkx2YQCeUfrDqpdx10Kt1tSsag2Nu8kuq9PfjJ
PrztRWij46ZA/an199ViGfY8KCsp7ZR6zgIEDzhGn4mPhDXxIaaSet0d0jec/fck
7p71cuPrMaRlSBWaE7NVu+nTFpvjHMpLbZICu0M2es/eDTHL5exE8eqMlH6tam5e
2Z8K+Yrf16T0ZYBpkd/DDE90l5GjfbF8qqJUlK9F32gw+4DS76Z8eZIj5b7BEfsw
AhkndDXHAmdGhfA4Uv3k39rCdqZZbHfU3Z7CJrQx5+9424qDcMTW02qKgIGAv8Zz
8Rkt3sXrGqjrcGi3xq9IzglakaFoQEtsOkHZgBNVQPNjcDFCNzKp4X4cr6vAMtJa
dQ+YCGA1MociOj0ZI4V6dsVdAfQgguG0DGFfxYT9LjgEVoWp7l/Eu/mOVLLc8q4M
QJoCCfH7OEEE8d4QGzQLK5+oZAmxOrzcGVcopJ1HhJT0x/CH5ZvOm4ltwvof6QN+
+tDI9p2TI0IGGWlUW0xhRs0S7T1rUFAoTFAPF4tS8oLShy3h6/JfTVIKqQnqrDIy
YzqTnOxmBt3RGgAN/6yY
=vLrU
-----END PGP SIGNATURE-----

--yrj/dFKFPuw6o+aM--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

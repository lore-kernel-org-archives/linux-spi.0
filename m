From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/2] spi: omap2-mcspi: Add FIFO buffer support
Date: Thu, 6 Jun 2013 11:30:32 +0100
Message-ID: <20130606103032.GR31367@sirena.org.uk>
References: <1370432398-7796-1-git-send-email-illia.smyrnov@ti.com>
 <1370432398-7796-3-git-send-email-illia.smyrnov@ti.com>
 <20130605120346.GZ31367@sirena.org.uk> <51B05FB8.6050903@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4958243636458554163=="
Cc: linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>,
 devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
 Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Illia Smyrnov <illia.smyrnov-l0cyMroinI0@public.gmane.org>,
 Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
 Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
 spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Illia Smyrnov <x0194613-l0cyMroinI0@public.gmane.org>
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <51B05FB8.6050903-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Id: linux-spi.vger.kernel.org


--===============4958243636458554163==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="q32ofrQ8UfzBLMEG"
Content-Disposition: inline


--q32ofrQ8UfzBLMEG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 06, 2013 at 01:08:56PM +0300, Illia Smyrnov wrote:
> On 06/05/2013 03:03 PM, Mark Brown wrote:

> >Why is this defined for slaves?  Surely the size of the FIFO in the
> >controller is a property of the controller not the slave?

> According to OMAP TRM [1] the FIFO buffer can be used by only one
> channel at a time. If several channels are selected and several FIFO
> enable bit fields are set to 1, the controller forces the buffer not
> to be used.

The controller ought to be able to figure this out for itself.  As a
first pass just grabbing the FIFO on a first come first served basis
will probably work well most of the time, the device would have to be
very active for it to constantly be doing transfers on all channels.

If there's more contention than that we probably ought to be looking at
how we handle this in general, it seems like we'd have more problems
than just the FIFO to worry about.

> If there are several slaves on the controller we must select which
> of slaves will use the FIFO for SPI transfers. Also, optimal FIFO

A single controller is only going to be able to talk to one slave at
once, everything on the bus except chip select is shared.

> size is heavily dependent of the SPI transfers length specific for
> certain slave.

The transfer length doesn't seem like something that we want to be
encoding in DT, particularly not indirectly - it is obviously readily
available at runtime, variable during runtime (eg, firmware download may
do large transfers on a device that only does small transfers most of
the time) and is something that updates to the drivers could change.

--q32ofrQ8UfzBLMEG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRsGTAAAoJELSic+t+oim9dfEQAJArV1dyQATWzmsuwfEfsXXg
ZNXsuLuPBaZ/jzt342a/MBDaSNeLyuxpq/w2XqP09zhydPozG00pOZJsSJgXxF9W
2mWXtDv7lo/BBbDzGjSSmocGD7fhoHkJZbF4dSVuDNQNEXB+eIkUxQJhUYi/N1k6
EmR43XboKn7FIA7eD/GPWFZ3flnx2ANygXisMpnGaAU+36hxX5CJHcQHK41+9SFx
5ZB18Qqwv8xOwdXobe/4CtDDBTKgKIn2JWQUwEAzzuE8BG1Wb95W/aQ7EhCrtJQE
tGdoLqAAS6fGSPZzpbCUZepbCswtTWqoGIY3SBt09wCBvSpysgn8SJtbkxRaeMTD
2LFzYN6xsZJ7chC1r1GAPyUxDhU01pUywApOUbF3j20n0uBhagv9gL0z51Fwnrrq
vOogf8CwC1DlQA2X+8up9YyHeZX4BQ6Y6lHv9uFSOkOw7SzD2TTxcI8+0g6JhU/5
SqZt0/E7WyDq5hjL/MfTao+uEq6dirjBQyAa0yazWo+nDS4sYPxBEXTcSmSzokI6
hFzXtGM85IB2UJiat0XgUTwUCGpVgWI2FkzoRDMs/w813I+Yd0SLHzFXdhLclKiM
4/7RkdF8hhxqLcf/1z8tPagKjOXkV1u5P4PYxsCSGA2/FR/PShwst59zcKgSJ7Ak
pRq9JpQyIwVCThfo8QPq
=gKwp
-----END PGP SIGNATURE-----

--q32ofrQ8UfzBLMEG--

--===============4958243636458554163==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devicetree-discuss mailing list
devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
https://lists.ozlabs.org/listinfo/devicetree-discuss

--===============4958243636458554163==--

From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2] spi: spidev: Add device tree bindings
Date: Sat, 27 Oct 2012 23:19:55 +0100
Message-ID: <20121027221955.GO4564@opensource.wolfsonmicro.com>
References: <1351238873-25230-1-git-send-email-maxime.ripard@free-electrons.com>
 <1351238873-25230-2-git-send-email-maxime.ripard@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3011836264867569386=="
Cc: spi-devel-general@lists.sourceforge.net, Shawn Guo <shawn.guo@linaro.org>,
 linux-arm-kernel@lists.infradead.org, Brian Lilly <brian@crystalfontz.com>
To: Maxime Ripard <maxime.ripard@free-electrons.com>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1351238873-25230-2-git-send-email-maxime.ripard@free-electrons.com>
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


--===============3011836264867569386==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2uzDqHpccQJpqF2n"
Content-Disposition: inline


--2uzDqHpccQJpqF2n
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 26, 2012 at 10:07:52AM +0200, Maxime Ripard wrote:
> This will allow to probe spidev from device tree

So, this isn't really something we should have in DT in this format -
the fact that we happen to control some device from userspace isn't a
generic property of the board really, we may end up changing our minds
on Linux too.  The most obvious thing for this seems to be to add the
specific devices to spidev as the OF bindings rather than just register
as some non-specific "spidev" so we can change our minds later about how
to handle the devices.  Not sure that's urgently tasteful but it does
mean we move the "we handle this in userspace" bit out of the .dts into
the kernel which seems better.

--2uzDqHpccQJpqF2n
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQjF4DAAoJELSic+t+oim9yREP/icNTZWyw52UUCQfkMn9492m
DxAwtufJADPdNWxqDufMRlto37Ajajn3TQXJ/pZSyFH/1sy8qnnQRVKDzynUN18T
Yb+Gn9/+XPOxfKWKkdEjn7iaWZVhOqirqRvKwWKjAC7ph3Ul9DhN+3N0ODaTluZ6
k7L6HOhtcwFAdez5TJ9zAGnz0k1UMLUUkqLYOYjEigIHA5vrMlF8VkSyHoNtaLXf
O/vc9RXEjMniHe39ueKdhne40XR+EBZZoSvGh6Fm0muIMIwfc1RhWKGjkAPpj+hV
u7P5FUJ4LQxfvDQ6QErv6R6rzwGfR9b9zVX3d5VU4o58gNqceWRRU1i+NfjExc7a
FUFM3ZXASPzTF7EZaLAoVp4I1/dVEVnHO3NiqQUTyHZQajjQ5Q9S692eW2dCxYpN
IDR/Ui0SCsNsxTjZ+0wFjbJKHPVpBnFogplNsf9+fCHB6DPkjm2rCuxL1sQHSUN8
ydWwfzM0XHT/ZVO983GRSq0GmvPCJEuKVFhYlYlzCYeSKuoF+CxO1+D7lOtI5UcA
nRFW7WRLYCt0VeXP9F67mF4APnflAak0iD25sN0E/DdUORhQ7YCXDWv8iKlQt+Jw
+Ln34DRhbGFdWXXpKOiUaTxETDfE7ZU8kFajSxlyN0k2teSb7UIilvvnP0Z451Ly
9hA+93u7mHzmdeu2LIx9
=5xKO
-----END PGP SIGNATURE-----

--2uzDqHpccQJpqF2n--


--===============3011836264867569386==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============3011836264867569386==--

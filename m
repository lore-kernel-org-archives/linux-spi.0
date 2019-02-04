From: NeilBrown <neil@brown.name>
Subject: Re: [PATCH 1/9 v3] staging: spi: mt7621: Switch to SPDX identifier
Date: Tue, 05 Feb 2019 10:09:26 +1100
Message-ID: <871s4njgm1.fsf@notabene.neil.brown.name>
References: <20190201101715.3760-1-sr@denx.de>
 <20190201130355.GG20797@sirena.org.uk>
 <87muncjyb3.fsf@notabene.neil.brown.name>
 <20190204085302.GB23441@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0137896376480850617=="
Cc: devel@driverdev.osuosl.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 John Crispin <john@phrozen.org>, linux-spi@vger.kernel.org,
 Sankalp Negi <sankalpnegi2310@gmail.com>, Stefan Roese <sr@denx.de>
To: Mark Brown <broonie@kernel.org>
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <20190204085302.GB23441@sirena.org.uk>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
List-Id: linux-spi.vger.kernel.org

--===============0137896376480850617==
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain

On Mon, Feb 04 2019, Mark Brown wrote:

> On Mon, Feb 04, 2019 at 09:34:56AM +1100, NeilBrown wrote:
>
>>  It is extremely common in the kernel for a file to start
>>    // SPDX-License-Identifier.....
>
>>  and to have that immediately followed by a comment lile:
>
>>  /*
>>   * .....
>>   * ....
>
> Yes, there was a lot of automated conversion AFAICT (and a lot of
> confusion with all this stuff only being documented in random mailing
> list posts for a long time).
>
>>  This patch makes this file match much of the rest of the kernel.  Why
>>  do you want something different?
>
> Like I said because it makes the comments look more like someone
> actually meant to add a C++ comment - it's what the rest of the
> subsystem is doing too.

Ahh.. the argument "what the rest of the subsystem is doing" makes a lot
more sense to me than "look more like someone actually mean to add a C++
comment", because I really don't understand how

    // SPDX-License-Identifier.....
    /*
     * old comment
     */

doesn't look like it was meant to be added.

Looking around the kernel, the pattern of "// SPDX-..." followed by a
"//" happens a lot in

     99 arch/csky/
    122 arch/nds32/
    152 sound/soc/
    201 drivers/media/
    273 arch/arm/

(numbers are how many instances I found), and less so in

     10 drivers/soc/
     11 drivers/soundwire/
     12 drivers/misc/
     12 drivers/pci/
     13 drivers/mfd/
     13 drivers/power/
     14 drivers/dma/
     14 drivers/input/
     14 scripts/coccinelle/
     16 drivers/leds/
     18 drivers/spi/
     25 arch/arm64/
     26 drivers/regulator/
     28 drivers/clk/
     29 drivers/net/
     36 tools/testing/
     52 drivers/pinctrl/

and much less else where.
Not at all in fs/ or mm/ or net/

It would be nice to have some consistency.

I would be in favour of avoiding // as much as possible.
The "// SPDX-" lines were (presumably) added nearly automatically.
I would prefer that if it were don't manually, it would always be

  /*
   * SPDX- ....
   * etc
   */

but I guess that horse has left the gate, though we do have that pattern
in about 129 files.

What a mess.

Any way, if you make a case based on "that is what most other files in
drivers/spi/ do", then I won't have any disagreement with that.

Thanks,
NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlxYxiYACgkQOeye3VZi
gbnL4Q/9FJafkAKSJ5jdtq8bSbGiv0QG7u7YbNOrK1X7c7gqbOcagGkh1cuy1CPW
56EaUS/jX74rb8KyDD18FfXG1HH3PIX4iC/lob+KITbH0JHC3xOk4iBRhfAvEDAr
knLfGzfEPi/6LrmpGklkKyydHUutnit1OOGriDsS8CIhLiszVSK2imjbmCGDmnMv
ZhfQjbAwCLTmRau6SFQYYkjnfsw25IFrxUSKIuajgUo4BIpt9c5LgUKYZ41lYC7l
E9rtRcdwIya0L670V67vHubpEJ+k3u7t5wo3fXQhq+UFuB7QrNTbhAzQR6sTeYR7
Q8pzRGYD3Emm030OtMDHJIWN+BUNMzPEONpLEQhgrEVt9i39FxLIKxZdR39lZL1g
Yu9O+UHV/EnxhQrO939OLGKhUXJNejOLaM40Rn+AfFBlTKZWV2Sm+fkFE6LQ4SBp
hh01qeMu9pCDIxkjHwyFC8FtkDNj4PhsEh1x33e2+4Vf53wrOQwT7V4GMvmfLaUm
OtuXVKwO3GkugRuEkqdqRpozzq8utPm5ODOAVdqHEo9+crlE5w0vUJaF9Na3P5vo
bdDw7wttyM6X1ACHrwReWPWjc4VJtbU0u6Oh3aMDnyXf29tZBSUBgJe9AiEthhXO
wgOBmk+lXFxLKbVKH9gmYg/Syejjyib+czCx7ToV5VtRJCvLDZA=
=bJOZ
-----END PGP SIGNATURE-----
--=-=-=--

--===============0137896376480850617==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel

--===============0137896376480850617==--

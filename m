From: Eric Anholt <eric@anholt.net>
Subject: Re: [PATCH] spi: Allow selecting BCM2835 SPI controllers on ARCH_BRCMSTB
Date: Thu, 09 May 2019 15:46:43 -0700
Message-ID: <8736lns0to.fsf@anholt.net>
References: <20190509203600.6867-1-f.fainelli@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Cc: stefan.wahren@i2se.com, wahrenst@gmx.net,
        bcm-kernel-feedback-list@Broadcom.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        "open list\:SPI SUBSYSTEM" <linux-spi@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
To: Florian Fainelli <f.fainelli@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190509203600.6867-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

--=-=-=
Content-Type: text/plain

Florian Fainelli <f.fainelli@gmail.com> writes:

> ARCH_BRCMSTB platforms have the BCM2835 SPI controllers (normal and
> auxiliary), allow selecting the two drivers on such platforms.
>
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Reviewed-by: Eric Anholt <eric@anholt.net>

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAlzUrdMACgkQtdYpNtH8
nuhySA/+N/RO3Z8Yoc+fKHRBsufh8kvxUe7tTv6WBVdDwEN6bRS6KVjUflP2j7fE
CuwNjCCJJNzFudG7ufzYGy4p6AVr1YK89a7V1eIlAmujkIzX7dhiXNqg8QxmBheZ
erNrMFofbYI1Vw5/6ULrlb8jsyOEsGcp/OdQbnwpc/0Ww9Bil4tV7e8v8tG4Ig1y
pzMoUnSw8qRpa5lz5yrIBLEDLlAz7TfofZMAa42s1VpGhkDuqgm5ug9UMq23eJkN
cTU0DZhXHAd9m0AU3hyree8tOFoSyP9woPL3Q9VIjgpLN3YOiLtKMoye7yYVCLTl
V80B4VM4YPVFjCH+agq0Y1jtuq2eQ/YlZdTpdiqnsVVRQ+dsSgKec3oz5IQrokbN
a+SuVspTcJUElx//UYqVuJFJLdTwreGnzeWi2U+DuhyzOtS2OQqb+VkKRQXa4vff
Q888zRwVoBm7hVUPkg/Kk8xvAZDH1j6DNLexQ1nHOc/0uKUQw4UHX7GvErUP0kdr
IREH+o/42O98FRKSd033J6ZSwW5K1MfFLZjZighzj2fC6oJ1EEZ3BhOQEmRvlNtJ
myw2ML/IoSg4qcR61ON23pplfALWtOzZi2pwWTNgamaDgdgzIDDXEdVmcPP0V0yU
xppd+BACNw0YMATfRAWIUbIFM7OGA71a4mKJ6cTw7Rl0FUYKei0=
=O1Gq
-----END PGP SIGNATURE-----
--=-=-=--

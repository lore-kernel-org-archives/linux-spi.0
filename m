From: Chris Brandt <Chris.Brandt-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Subject: RE: [PATCH] spi: rspi: avoid uninitialized variable access
Date: Tue, 8 Nov 2016 17:20:50 +0000
Message-ID: <SG2PR06MB11655C10710B5FDDEAEA48218AA60@SG2PR06MB1165.apcprd06.prod.outlook.com>
References: <20161108134624.1905209-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Cc: Hiep Cao Minh <cm-hiep-HEF513clHfp3+QwDJ9on6Q@public.gmane.org>,
        "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20161108134624.1905209-1-arnd-r2nGTMty4D4@public.gmane.org>
Content-Language: en-US
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Since I was CC-ed, I'll add in my opinion:


While Geert already pointed out the spelling mistake (_in_or_our >> _in_or_=
out), since that function is only just for qspi versions, a better function=
 name should have been "qspi_pio_transfer_in_or_out"



However....

On 11/8/2016, Arnd Bergmann wrote:
> This simplifies it again by keeping the two separate, which then ends up
> avoiding that warning.

I agree with Arnd's method of NOT adding a new "rspi_pio_transfer_in_or_our=
" function and instead just doing it in the existing qspi_transfer_ functio=
ns.



Side note: The RSPI in the RZ/A1 devices also have FIFOs which can be used =
to reduce the number of interrupts in pio transfers, so maybe someday I'll =
make a similar change for non-qspi devices as well.


Chris
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

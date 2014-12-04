From: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] spi: spi-fsl-spi: Return an error code in fsl_spi_do_one_msg()
Date: Thu, 04 Dec 2014 20:29:30 +0100
Message-ID: <5480B61A.2020600@gmail.com>
References: <1417698947-4273-1-git-send-email-fabio.estevam@freescale.com>	<CAFSsGVv5=gJ2t-sWwTGqDcWaaYVU7o6VqZEL4mvxgohkkvBxmw@mail.gmail.com>	<CAOMZO5Dfs=+UP=76gzG1LisoWAZaYALxmXg0N+evTVCkFhSs5Q@mail.gmail.com>	<5480A56E.8050308@gmail.com> <CAOMZO5Ahv23kjBXvapL8gGxtHcrOiEwnSXOAFyQ8RPBiK6rwKQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	"linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAOMZO5Ahv23kjBXvapL8gGxtHcrOiEwnSXOAFyQ8RPBiK6rwKQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Am 04.12.2014 um 19:52 schrieb Fabio Estevam:
> On Thu, Dec 4, 2014 at 4:18 PM, Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> 
>> OK, just submitted the fix as a separate patch.
> 
> You mixed the two fixes in one patch. That was not really what I suggested.
> 
Sorry, was a misunderstanding. I re-sent the fix with only removing the
unused variable assignment.

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

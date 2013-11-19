From: Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH] spi/qspi: cleanup qspi remova path and error check.
Date: Tue, 19 Nov 2013 17:20:57 +0530
Message-ID: <528B50A1.1080609@ti.com>
References: <1384858703-30938-1-git-send-email-sourav.poddar@ti.com> <20131119113125.GZ2674@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Cc: <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20131119113125.GZ2674-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Tuesday 19 November 2013 05:01 PM, Mark Brown wrote:
> On Tue, Nov 19, 2013 at 04:28:23PM +0530, Sourav Poddar wrote:
>> There is a bug in qspi removal path, as a result of which
>> qspi cannot be removed when used as a module. The patch
>> solves the bug and qspi can be removed cleanly.
> What is the bug?  The important bit of information is what's actually
> being changed.
>
pm_runtime api is not used to properly disable the PM part.
spi_unregister_master(qspi->master) shows a NULL pointer dereference.
>> Also align the runtime error path check through out the code.
Ok.
> This should be split out.

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

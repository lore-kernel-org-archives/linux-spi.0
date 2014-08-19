From: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] spi: Only call transfer_one() if we have buffers to transfer
Date: Tue, 19 Aug 2014 12:36:41 -0700
Message-ID: <CAD=FV=UnqPftKx7NSRn7Td1AeXkwnwOpMuaJmxWz-P3Ce1qpLQ@mail.gmail.com>
References: <1408203002-26403-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Addy Ke <addy.ke-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	olof-gZy3mtb3KLqsTnJN9+BGXg@public.gmane.org,
	Lists linaro-kernel <linaro-kernel-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>,
	Mark Brown <broonie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1408203002-26403-1-git-send-email-broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Mark,

On Sat, Aug 16, 2014 at 8:30 AM, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> From: Mark Brown <broonie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>
> Client drivers such as the ChomeOS EC driver sometimes use transfers with
> no buffers and only a delay specified in order to allow a delay after the
> assertion of /CS. Rather than require controller drivers handle this noop
> case gracefully put checks in the core to ensure that we don't call into
> the controller for such transfers.
>
> Reported-by: Addy Ke <addy.ke-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
> Signed-off-by: Mark Brown <broonie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> ---
>
> Completely untested at this point.
>
>  drivers/spi/spi.c | 44 ++++++++++++++++++++++++++------------------
>  1 file changed, 26 insertions(+), 18 deletions(-)

Thank you for writing this patch.  It looks great and works for me.

Tested-by: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Reviewed-by: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: Ezequiel Garcia <ezequiel-30ULvvUtt6G51wMPkGsGjgyUoB5FGQPZ@public.gmane.org>
Subject: Re: [PATCH v2] spi: bitbang: Make setup_transfer() callback optional
Date: Tue, 14 Apr 2015 12:36:22 -0300
Message-ID: <552D33F6.2020407@vanguardiasur.com.ar>
References: <1428919685-14190-1-git-send-email-per.nilsson@xelmo.com> <1429018817-18117-1-git-send-email-per.nilsson@xelmo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	nios2-dev-g9ZBwUv/Ih/yUk5EbOjzuce+I+R0W71w@public.gmane.org
To: Pelle Nilsson <per.nilsson-5TWeZ6kPplYAvxtiuMwx3w@public.gmane.org>, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1429018817-18117-1-git-send-email-per.nilsson-5TWeZ6kPplYAvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>



On 04/14/2015 10:40 AM, Pelle Nilsson wrote:
> Some controller drivers have no need of this callback (spi-altera even
> causes a NULL pointer dereference because it doesn't register the callback,
> falsely assuming that it is already optional).
> 
> Fixes: 30af9b558a56 ("spi/bitbang: Drop empty setup() functions")
> Signed-off-by: Pelle Nilsson <per.nilsson-5TWeZ6kPplYAvxtiuMwx3w@public.gmane.org>

Reviewed-by: Ezequiel Garcia <ezequiel.garcia-30ULvvUtt6G51wMPkGsGjgyUoB5FGQPZ@public.gmane.org>

Please note the merge window is open, so don't expect Mark to pick
your change soon.
-- 
Ezequiel Garcia, VanguardiaSur
www.vanguardiasur.com.ar
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

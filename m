From: Shubhrajyoti Datta <shubhrajyoti.datta-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCHv2] spi: zynqmp: Add runtime support
Date: Mon, 3 Apr 2017 16:03:33 +0530
Message-ID: <CAKfKVtHT6qmarkDd7KpTtO=75=39+ABUxYGoYHm0iUy6hvQTTQ@mail.gmail.com>
References: <1488517884-31977-1-git-send-email-shubhrajyoti.datta@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Michal Simek <michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>,
        =?UTF-8?Q?S=C3=B6ren_Brinkmann?= <soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
To: Shubhrajyoti Datta <shubhrajyoti.datta-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1488517884-31977-1-git-send-email-shubhrajyoti.datta-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Fri, Mar 3, 2017 at 10:41 AM, Shubhrajyoti Datta
<shubhrajyoti.datta-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org> wrote:
> Add PM runtime support for the zynqmp qspi driver.
> spi core has the runtime support register to the spi core auto runtime pm.
> Also removes the clock enable and disable as the spi core will
> now do it for us.
>
> Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
> ---
> v2:
> Update the commit message.

If there are no further comments can this be merged.
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

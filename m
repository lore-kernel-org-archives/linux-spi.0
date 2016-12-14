From: Hauke Mehrtens <hauke-5/S+JYg5SzeELgA04lAiVw@public.gmane.org>
Subject: Re: [PATCH v2 1/2] spi: add check_finished() callback
Date: Wed, 14 Dec 2016 22:48:01 +0100
Message-ID: <63d64bd4-2efa-f1ea-6c7f-3d9b9b438f03@hauke-m.de>
References: <20161211200350.13590-1-hauke@hauke-m.de>
 <20161211200350.13590-2-hauke@hauke-m.de>
 <20161214152156.uehjhqoxpng47pnh@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, hauke.mehrtens-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org,
        thomas.langer-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, daniel.schwierzeck-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org,
        john-Pj+rj9U5foFAfugRpC6u6w@public.gmane.org, nbd-Vt+b4OUoWG0@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20161214152156.uehjhqoxpng47pnh-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 12/14/2016 04:21 PM, Mark Brown wrote:
> On Sun, Dec 11, 2016 at 09:03:49PM +0100, Hauke Mehrtens wrote:
> 
>> This callback checks if the transfer really finished. This allows a
>> driver to directly call the completion list in the irq handler and it
>> does not have to bushy wait till the hardware is really finished in the
>> IRQ handler. This is needed for the Lantiq driver.
> 
> This is really hard to understand and does not seem like a good
> interface, it's going to be confusing for anyone who doesn't have
> hardware which is broken in whatever way your hardware is broken and it
> sounds like it's misnamed for your hardware since my guess is that you
> actually want to wait for something in the function rather than just
> check to see if the transfer completed.
> 
> Why not just have your interrupt handler schedule something on a
> workqueue to check whatever it is needs checking here?
Ok, I will try to find a different way for this problem.

I tried to avoid this extra workqueue by usig the normal spi workqueue.

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

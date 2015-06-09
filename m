From: Pascal Huerst <pascal.huerst-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] spi: omap2-mcspi: Add calls for pinctrl state select
Date: Tue, 09 Jun 2015 13:16:33 +0200
Message-ID: <5576CB11.7010905@gmail.com>
References: <1431519316-30989-1-git-send-email-pascal.huerst@gmail.com> <20150513181536.GI2761@sirena.org.uk> <5559D4BC.6010606@gmail.com> <20150519121225.GM2761@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150519121225.GM2761-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hey Mark,

On 19.05.2015 14:12, Mark Brown wrote:
> On Mon, May 18, 2015 at 02:02:04PM +0200, Pascal Huerst wrote:
>> On 13.05.2015 20:15, Mark Brown wrote:
> 
>>> We should still be checking if we succesfully changed the state when
>>> there is a state provided shouldn't we?
> 
>> I agree, but if I git grep for such calls, nobody seems to check the
>> return values of these functions. Shall I add a check and print a
>> message if the call fails?
> 
> Yes, please.

Sorry for the late reply.

There is already a message printed on failure in the subsystem. See:
http://lxr.free-electrons.com/source/drivers/pinctrl/core.c#L1250

So I don't see the need for another message, right?
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

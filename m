From: Pascal Huerst <pascal.huerst-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] spi: omap2-mcspi: Add calls for pinctrl state select
Date: Mon, 18 May 2015 14:02:04 +0200
Message-ID: <5559D4BC.6010606@gmail.com>
References: <1431519316-30989-1-git-send-email-pascal.huerst@gmail.com> <20150513181536.GI2761@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150513181536.GI2761-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>



On 13.05.2015 20:15, Mark Brown wrote:
> On Wed, May 13, 2015 at 02:15:16PM +0200, pascal.huerst-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org wrote:
> 
>> This adds calls to pinctrl subsystem in order to switch pin states
>> on suspend/resume if you provide a "sleep" state in DT.
> 
>> If no "sleep" state is provided in DT, these calls turn
>> to NOPs, so we don't need error checking here.
> 
> We should still be checking if we succesfully changed the state when
> there is a state provided shouldn't we?

I agree, but if I git grep for such calls, nobody seems to check the
return values of these functions. Shall I add a check and print a
message if the call fails?
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

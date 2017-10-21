From: Angelo Dureghello <angelo-BIYBQhTR83Y@public.gmane.org>
Subject: Re: [RFC] patch to spi-fsl-dspi.c to enable Coldfire mcf5441x
Date: Sun, 22 Oct 2017 00:37:47 +0200
Message-ID: <5132a92c-ae76-2392-c075-0b893964c658@sysam.it>
References: <ff0014ac-1d46-5014-4371-041ccdba1fa5@sysam.it>
 <20171021102240.kwsjgmpjdom2np77@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        Greg Ungerer <gregungerer-ncau/BB9MAPvnOemgxGiVw@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20171021102240.kwsjgmpjdom2np77-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Content-Language: en-US
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Mark,

On 21/10/2017 12:22, Mark Brown wrote:
> On Fri, Oct 13, 2017 at 02:08:54AM +0200, Angelo Dureghello wrote:
> 
>> i had the need to use the dspi module of Coldfire mcf5441x.
>> I have seen the spi-fsl-dspi.c was already covering this
>> CPU but was not selectable, and not working out of the box
>> once enabled form Kconfig.
> 
> Please submit changes using the format covered in SubmittingPatches,
> this allows things to be handled using tools and for review by e-mail.
> 

sorry, was not sure if the list could reply to my RFC so i 
submitted a regular patch yesterday, just before your reply.

https://patchwork.kernel.org/patch/10018363/


Regards,
Angelo Dureghello
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

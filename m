From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] devicetree - document using aliases to set spi bus number.
Date: Wed, 25 May 2016 20:44:24 -0500
Message-ID: <CAL_JsqJwQvPGtscheZjoJyhF1UPxDSqbS-QB9qm3M4HbpOicVA@mail.gmail.com>
References: <1464107960-10775-1-git-send-email-christer@weinigel.se>
 <20160524172045.GN8206@sirena.org.uk> <57449784.4070108@weinigel.se>
 <20160524183256.GP8206@sirena.org.uk> <5744E51A.1040506@gmail.com>
 <20160525174932.GA10753@rob-hp-laptop> <5745E9B6.5090204@gmail.com>
 <20160525184442.GE8206@sirena.org.uk> <57464D0A.1030706@weinigel.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	"linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Christer Weinigel <christer-rKHMIqA5R6gwFerOooGFRg@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <57464D0A.1030706-rKHMIqA5R6gwFerOooGFRg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Wed, May 25, 2016 at 8:10 PM, Christer Weinigel <christer-rKHMIqA5R6gwFerOooGFRg@public.gmane.org> wrote:
> On 05/25/2016 08:44 PM, Mark Brown wrote:
>> On Wed, May 25, 2016 at 11:06:46AM -0700, Frank Rowand wrote:
>>> On 5/25/2016 10:49 AM, Rob Herring wrote:
>>
>>>> Things get undocumented all the time when we deprecate them.
>>
>>> If it is deprecated then it should be documented as deprecated
>>> so people do not attempt to use it.
>>
>> Or we could just remove the code, we don't appear to have any in
>> tree users anyway (the few in tree aliases for SPI buses I can see
>> are string based).
>
> Lovely.  "Here's something that's simple and useful for users.  Let's
> break it".  What part of "we do not break userspace" do you not
> understand?  Because that would be a user visible change.

The other saying is "if it is not upstream, it doesn't exist." That
said, I don't think we should remove it. Maybe some time later, but
first we need a suitable alternative.

Rob
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

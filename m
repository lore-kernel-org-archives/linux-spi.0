From: Andrew Bresticker <abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH V2 0/2] spi: IMG SPFI driver
Date: Fri, 14 Nov 2014 10:46:22 -0800
Message-ID: <CAL1qeaFM5wLMtGBmHnwwKeq7ps1RzL_QMRoUbAbF9iSTJMEXBg@mail.gmail.com>
References: <1415848096-20079-1-git-send-email-abrestic@chromium.org>
	<20141113173631.GI3815@sirena.org.uk>
	<20141114150411.GB3815@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>,
	Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>,
	Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	James Hartley <James.Hartley-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>,
	Ezequiel Garcia <Ezequiel.Garcia-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>,
	"devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20141114150411.GB3815-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Fri, Nov 14, 2014 at 7:04 AM, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> On Thu, Nov 13, 2014 at 05:36:31PM +0000, Mark Brown wrote:
>> On Wed, Nov 12, 2014 at 07:08:14PM -0800, Andrew Bresticker wrote:
>> > This series adds support for the Sychronous Peripheral Flash Interface
>> > master found on IMG SoCs.  The controller supports up to 5 chip-select
>> > lines and single, dual, and optionally quad, mode transfers.
>
>> Applied both, thanks.
>
> ...and reverted since they fail to build in x86 allmodconfig (due to a
> missing linux/interrupt.h it seems).  Please check and resend.

Sorry about that :(.  v3 incoming...
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

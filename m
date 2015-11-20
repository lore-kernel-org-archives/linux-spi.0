From: Marcus Weseloh <mweseloh42-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] spi: dts: sun4i: Add support for inter-word
 wait cycles using the SPI Wait Clock Register
Date: Fri, 20 Nov 2015 17:45:48 +0100
Message-ID: <CAGNoLaPLXOmObXgW0YsN8giM1WCRDn7MieTBcKOE5sjXbjg0GA@mail.gmail.com>
References: <1447948422-4915-1-git-send-email-mweseloh42@gmail.com>
	<1447948422-4915-2-git-send-email-mweseloh42@gmail.com>
	<CAGRGNgWQLE5h03+4shLmqD6iW_p=L-i3ewdLb8ndWpxGHWh4rQ@mail.gmail.com>
	<CAGNoLaNhD73N5_1_NbkvRFnwNqO5ehQBTyeCEgzFVgWCrJZmWQ@mail.gmail.com>
	<CAGRGNgV0kOkye-Zu4WGQKgGim7N2HB9rAFJ3HNQS89Rr6_WexQ@mail.gmail.com>
	<CAGNoLaOOz2ACtS5iRUxjOknisMHm2Ow3OVsLkqpWuNU4J-9v-A@mail.gmail.com>
	<20151120161246.GB21921@rob-hp-laptop>
Reply-To: mweseloh42-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Julian Calaby <julian.calaby-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
	Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"Mailing List, Arm" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	"linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-sunxi+bncBDFO74UEV4IRBPM4XWZAKGQEZ2FTVCI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <20151120161246.GB21921@rob-hp-laptop>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
List-Id: linux-spi.vger.kernel.org

2015-11-20 17:12 GMT+01:00 Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>:
> On Fri, Nov 20, 2015 at 02:56:34PM +0100, Marcus Weseloh wrote:
>> > (and the wdelay should
>> > arguably be a core-spi thing, not a sunxi thing, but that's a separate
>> > discussion)
>>
>> I've been thinking about that, but it seemed to big a change to
>> attempt with my limited kernel hacking experience.
>
> It is not any bigger. You just need to document it in the core binding.
> It would still be read by the drivers using it.

Julien, Rob: thanks for your comments! Ok, I will make the following changes:

- remove "sun4i,spi-wdelay" from the sun4i binding and add the
property to the spi-bus.txt binding instead
- remove the comment about the additional 3 cycles from the documentation
- modfy the spi-sun4i driver to take care of the minimum 3 cycle period

Does that sound right?

And maybe I could also use a more descriptive name for the property,
maybe "spi-word-wait-cycles"?

Cheers,

   Marcus

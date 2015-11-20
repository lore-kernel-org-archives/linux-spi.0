From: Julian Calaby <julian.calaby-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] spi: dts: sun4i: Add support for inter-word
 wait cycles using the SPI Wait Clock Register
Date: Fri, 20 Nov 2015 21:12:04 +1100
Message-ID: <CAGRGNgV0kOkye-Zu4WGQKgGim7N2HB9rAFJ3HNQS89Rr6_WexQ@mail.gmail.com>
References: <1447948422-4915-1-git-send-email-mweseloh42@gmail.com>
 <1447948422-4915-2-git-send-email-mweseloh42@gmail.com> <CAGRGNgWQLE5h03+4shLmqD6iW_p=L-i3ewdLb8ndWpxGHWh4rQ@mail.gmail.com>
 <CAGNoLaNhD73N5_1_NbkvRFnwNqO5ehQBTyeCEgzFVgWCrJZmWQ@mail.gmail.com>
Reply-To: julian.calaby-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"Mailing List, Arm" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	"linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Marcus Weseloh <mweseloh42-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-sunxi+bncBDQIP76OUQLBBCHEXOZAKGQEQV7PCKQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <CAGNoLaNhD73N5_1_NbkvRFnwNqO5ehQBTyeCEgzFVgWCrJZmWQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
List-Id: linux-spi.vger.kernel.org

Hi Marcus,

On Fri, Nov 20, 2015 at 7:45 PM, Marcus Weseloh <mweseloh42-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> Hi Julian,
>
> 2015-11-19 23:59 GMT+01:00 Julian Calaby <julian.calaby-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>:
>> Should you possibly hide the 3 clock periods from the user?
>>
>> I.e. they set whatever they want for the wdelay, we set it to the
>> closest number we can that's greater or equal to what they ask for.
>
> That's a good idea and much better than having to remember to subtract
> 3 cycles from the desired wait time!
>
> But it would mean that this magic number becomes part of the driver
> code. I have found no official documentation that mentions those
> additional cycles. While I have checked many different transmission
> speeds using both CDR1 and CDR2 divider configurations, there is still
> the possibility that the behaviour changes with weird SPI module
> configurations... And I've only tested it on A20 hardware. So it would
> be great if somebody else with access to A10 hardware and an
> oscilloscope could check if we have a consistent 3 cycle overhead.

Having magic numbers is kind-of a drivers' job. (and the wdelay should
arguably be a core-spi thing, not a sunxi thing, but that's a separate
discussion)

If it is different for other SoCs, then you might have to move that
constant somewhere else and introduce new compatible strings for them.

Thanks,

-- 
Julian Calaby

Email: julian.calaby-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Profile: http://www.google.com/profiles/julian.calaby/

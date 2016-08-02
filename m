From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v4 1/2] of: add J-Core SPI master bindings
Date: Tue, 2 Aug 2016 17:41:48 -0500
Message-ID: <CAL_JsqKMq5QTW7wR6y09dq3Q1ZShiLzXSsmt+Q0ko0w+V1tMfw@mail.gmail.com>
References: <cover.1469686300.git.dalias@libc.org> <9813bf559ad89ca6fecc438d9176d634bbc122a0.1469686300.git.dalias@libc.org>
 <20160729205838.GA28548@rob-hp-laptop> <20160802220035.GB15995@brightrain.aerifal.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	SH-Linux <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
To: Rich Felker <dalias-8zAoT0mYgF4@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160802220035.GB15995-C3MtFaGISjmo6RMmaWD+6Sb1p8zYI1N1@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Tue, Aug 2, 2016 at 5:00 PM, Rich Felker <dalias-8zAoT0mYgF4@public.gmane.org> wrote:
> On Fri, Jul 29, 2016 at 03:58:38PM -0500, Rob Herring wrote:
>> On Tue, May 17, 2016 at 11:19:25PM +0000, Rich Felker wrote:
>> > Signed-off-by: Rich Felker <dalias-8zAoT0mYgF4@public.gmane.org>
>> > ---
>> >  .../devicetree/bindings/spi/jcore,spi.txt          | 30 ++++++++++++++++++++++
>> >  1 file changed, 30 insertions(+)
>> >  create mode 100644 Documentation/devicetree/bindings/spi/jcore,spi.txt
>>
>> Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
>
> Thanks. Since I switched to to using the clk framework rather than a
> clock-frequency property (at Mark Brown's suggestion/request), I'll be
> submitting one more version for your review.
>
> After that, who should be responsible for upstreaming this and the
> other binding patches? You, me, or the subsystem maintainers that the
> drivers are going through?

Mark will take the SPI changes. I generally only take standalone
binding patches thru the DT tree.

Rob
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

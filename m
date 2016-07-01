From: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 4/4] spi: Document option to insert delay between transactions
Date: Thu, 30 Jun 2016 21:45:59 -0700
Message-ID: <CAD=FV=VdzacSwaLfAHSkBdQAhDpxGa41w2kk2vim7shLv1W_wg@mail.gmail.com>
References: <1467258867-117727-1-git-send-email-apronin@chromium.org>
 <1467258867-117727-4-git-send-email-apronin@chromium.org> <CAMuHMdUBcDUoMok9tkxJzGekkLWA=bya0zHXWqHbGp0BGmeZUg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: apronin-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	"linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAMuHMdUBcDUoMok9tkxJzGekkLWA=bya0zHXWqHbGp0BGmeZUg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi,

On Thu, Jun 30, 2016 at 12:12 AM, Geert Uytterhoeven
<geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org> wrote:
> CC devicetree
>
> On Thu, Jun 30, 2016 at 5:54 AM,  <apronin-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org> wrote:
>> From: Andrey Pronin <apronin-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
>>
>> Some devices may need CS to be deasserted for some time
>> between transactions. Added a new capability to guarantee
>> a delay between SPI transactions for the device.
>>
>> Signed-off-by: Andrey Pronin <apronin-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
>> ---
>>  Documentation/devicetree/bindings/spi/spi-bus.txt | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/spi/spi-bus.txt b/Documentation/devicetree/bindings/spi/spi-bus.txt
>> index 1b7ffd4..87c117a 100644
>> --- a/Documentation/devicetree/bindings/spi/spi-bus.txt
>> +++ b/Documentation/devicetree/bindings/spi/spi-bus.txt
>> @@ -70,6 +70,8 @@ contain the following properties.
>>                 sleep if there was no SPI activity (msec).
>>  - cs-wake-duration - (optional) Time it takes the device to wake up after
>>                 toggling CS if it went to sleep (msec).
>> +- xfer-delay      - (optional) Delay to insert between SPI transactions
>> +               to guarantee that CS is deasserted at least for some time.

msec?  usec?  nsec?

Also, as with the other patch, this should be _before_ the code
change, so this should really be patch 3 not patch 4.
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

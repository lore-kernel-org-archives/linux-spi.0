From: "Andrew F. Davis" <afd@ti.com>
Subject: Re: [PATCH 1/2] dt-bindings: GPIO: Add generic serializer binding
Date: Wed, 30 Dec 2015 11:05:20 -0600
Message-ID: <56840ED0.6070205@ti.com>
References: <1449863184-29668-1-git-send-email-afd@ti.com>
 <1449863184-29668-2-git-send-email-afd@ti.com>
 <CACRpkdaV_dxzWUQcJ8pwPUDQNJ8qLhCvLvE9tBYFcTTGMoumWQ@mail.gmail.com>
 <566EF12C.4060509@ti.com>
 <CAL_Jsq+kYSJQd003RhYTeVFv6xLaSCxzZK7wnF2LVs502sWu4g@mail.gmail.com>
 <566F4E9B.8090202@ti.com>
 <CACRpkdYapF8br=c3utUmMbmPxyHwxZuT5pC8N-pySPY7dtEwng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Rob Herring <robh+dt@kernel.org>,
	"linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Alexandre Courbot <gnurou@gmail.com>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	"linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
To: Linus Walleij <linus.walleij@linaro.org>
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <CACRpkdYapF8br=c3utUmMbmPxyHwxZuT5pC8N-pySPY7dtEwng@mail.gmail.com>
Sender: linux-gpio-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 12/22/2015 03:51 AM, Linus Walleij wrote:
> On Tue, Dec 15, 2015 at 12:19 AM, Andrew F. Davis <afd@ti.com> wrote:
>> [Rob]
>>> I agree the generic version is fine (or find who made the first part
>>> ;)). What "pisosr" is is not very obvious though. Having 74165 in the
>>> compatible would make it somewhat more obvious it is a standard logic
>>> part.
>>>
>>
>> A quick search shows shift-registers being made from vacuum tubes for
>> the Colossus! Those might work with this driver if you could match the
>> voltage to an SPI bus... :)
>>
>> I agree about the name not being very good, but I'm not sure about
>> 74165 ether as it is also just a single part number.
>
> We can add many compatible strings so it's not an issue.
> "ti,74165" works for me as TI invented the 74xx series.
>

Free advertising for our parts :)

>> The idea was to
>> have a non-part number compatible string for any shift-register you
>> can hook to the SPI line.
>
> Again, one does not exclude the other. I'm happy with a generic
> compatible *and* "ti,74165".
>
>> That way when we have boards with a sn65x882
>> or something we wont have to call it a 74165. But I guess that's why
>> it's a "compatible:" string, and not "is-a:" string.
>
> Compatible ranges from the specific to the more generic
> so compatible = "ti,74165", "pisosr"; is just fine. Something
> will match if there is a suitable driver. The OS may choose to
> provide something part-specific or something more generic.
>

And so we won't need to have "ti,74165" in the driver itself,
if we just have "pisosr", then dts files can use what ever they
like to correctly identify the part then fall back to pisosr.

compatible = "company,random_numbers_of_exact_part_actually_on_board", "pisosr";

Andrew

> Yours,
> Linus Walleij
>

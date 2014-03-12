From: Max Filippov <jcmvbkbc@gmail.com>
Subject: Re: [PATCH v2 2/3] spi/xtensa-xtfpga: add DT binding documentation
Date: Wed, 12 Mar 2014 21:21:15 +0400
Message-ID: <CAMo8BfLDXYaovZ1U1hcXKCv+EX=wuda8uHgmTDP3Ozaq2Z=SKg@mail.gmail.com>
References: <1394626865-15105-1-git-send-email-jcmvbkbc@gmail.com>
	<1394626865-15105-3-git-send-email-jcmvbkbc@gmail.com>
	<20140312151320.GB5035@e106331-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "linux-xtensa@linux-xtensa.org" <linux-xtensa@linux-xtensa.org>,
	"linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	Chris Zankel <chris@zankel.net>,
	Marc Gauthier <marc@cadence.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	"grant.likely@linaro.org" <grant.likely@linaro.org>,
	Andrew Morton <akpm@linux-foundation.org>
To: Mark Rutland <mark.rutland@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140312151320.GB5035@e106331-lin.cambridge.arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Wed, Mar 12, 2014 at 7:13 PM, Mark Rutland <mark.rutland@arm.com> wrote:
> On Wed, Mar 12, 2014 at 12:21:04PM +0000, Max Filippov wrote:
>> Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
>> ---
>>  Documentation/devicetree/bindings/spi/spi-xtensa-xtfpga.txt | 9 +++++++++
>>  1 file changed, 9 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/spi/spi-xtensa-xtfpga.txt
>>
>> diff --git a/Documentation/devicetree/bindings/spi/spi-xtensa-xtfpga.txt b/Documentation/devicetree/bindings/spi/spi-xtensa-xtfpga.txt
>> new file mode 100644
>> index 0000000..b6ebe2b
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/spi/spi-xtensa-xtfpga.txt
>> @@ -0,0 +1,9 @@
>> +Cadence Xtensa XTFPGA platform SPI controller.
>> +
>> +This simple SPI master controller is built into xtfpga bitstreams and is used
>> +to control daughterboard audio codec.
>> +
>> +Required properties:
>> +- compatible: should be "cdns,xtfpga-spi".
>
> Is that the official name of the block? Nothing more specific?

There's no official name, so I composed this from the official name
of the platform + the block function. AFAIK there's single version of
this IP block. Marc G., please correct me if I'm wrong.

>> +- reg: physical base address of the controller and length of memory mapped
>> +  region.
>
> No interrupts?

Correct.

> Otherwise, this looks fine to me.

-- 
Thanks.
-- Max

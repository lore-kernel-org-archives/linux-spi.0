From: Thor Thayer <tthayer@opensource.altera.com>
Subject: Re: [RFC/PATCHv2 3/3] spi: dw-spi: Pointers select 16b vs. 32b DesignWare
 access
Date: Tue, 10 Mar 2015 17:22:09 -0500
Message-ID: <54FF6E91.1010704@opensource.altera.com>
References: <1425685594-26595-1-git-send-email-tthayer@opensource.altera.com>	<1425685594-26595-4-git-send-email-tthayer@opensource.altera.com>	<CAHp75VcceG2O+YCw4twBzC_2v9+XQRpfBxMqGXERi3amnj3rdA@mail.gmail.com>	<54FDDFE6.8010109@opensource.altera.com>	<CAHp75Vf6dgobzZyJxu8eiqGgC7FRrwLCmyMf5Agk6S3jHDj4bw@mail.gmail.com>	<54FDF8BB.4050202@opensource.altera.com>	<CAHp75VcmNOaiyRNLFzQT7nKS6piZzpYSoS785J86rKtNXx6KNg@mail.gmail.com>	<54FF556A.3020408@opensource.altera.com> <CAHp75VcgX8WWPkHVH80eQXGAG76xSG1YpDfb24E6aWA7GZ3OZg@mail.gmail.com>
Reply-To: <tthayer@opensource.altera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Mark Brown <broonie@kernel.org>,
	Grant Likely <grant.likely@linaro.org>,
	Jiri Kosina <jkosina@suse.cz>, Pawel Moll <pawel.moll@arm.com>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	ijc+devicetree <ijc+devicetree@hellion.org.uk>,
	dinguyen <dinguyen@opensource.altera.com>,
	Linux Documentation List <linux-doc@vger.kernel.org>,
	<linux-spi@vger.kernel.org>,
	devicetree <devicetree@vger.kernel.org>,
	Thor Thayer <tthayer.linux@gmail.com>,
	Axel Lin <axel.lin@ingics.com>, baruch <baruch@tkos.co.il>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jingoo Han <jg1.han@samsung.com>,
	Kumar Gala <galak@codeaurora.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <CAHp75VcgX8WWPkHVH80eQXGAG76xSG1YpDfb24E6aWA7GZ3OZg@mail.gmail.com>
Sender: linux-doc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org



On 03/10/2015 03:44 PM, Andy Shevchenko wrote:
> On Tue, Mar 10, 2015 at 10:34 PM, Thor Thayer
> <tthayer@opensource.altera.com> wrote:
>> On 03/09/2015 03:02 PM, Andy Shevchenko wrote:
>>>
>>> On Mon, Mar 9, 2015 at 9:47 PM, Thor Thayer
>>> <tthayer@opensource.altera.com> wrote:
>>>>
>>>> On 03/09/2015 01:54 PM, Andy Shevchenko wrote:
>>>
>>>
>>>> Yes, I just need the 32 bit write. I was trying to remain consistent but
>>>> I
>>>> agree that only changing only writes would minimize the changes.
>>>
>>>
>>> Which is still makes me anxious.
>>>
>>> I have briefly read a chapter for SPI in pdf you sent link to. I
>>> didn't find anything except SPI supports 32 bit data width.
>>>
>>> It would be nice if you ping your HW engineers and clarify what
>>> exactly is happening there.
>>>
>>
>> I confirmed with our HW engineer that writes are required to be 32 bits. We
>> are in the process of updating our documentation to explicitly say this.
>>
>> Since there are no byte enables on our 32 bit APB interface, writing only 1
>> or 2 bytes could corrupt the other bytes in the 32 bit word. The 32 bit
>> write enforces requiring an explicit read/modify/write for less than 32 bit
>> writes.
>>
>> Since reads are non-destructive (nothing is being written back into the
>> register), it is safe for all reads to get promoted to 32 bit reads.
>
> Thanks for detailed explanation!
>
>> Is it preferable to have both 32 bit reads and writes for consistency?
>>
>> Or is it preferable to make the minimal number of changes which would be to
>> only add a 32 bit write function?
>
> Both I think just to be more clear.
>
> However, I'm now considering what if we just replace
> dw_{write/read}w() by l-variants without any additional DT property
> and accessor functions?
> Would it work for both your cases (old chip, new chip)?
> On my side I may test this on Intel MID.
>

Yes, this would be the simplest solution. The l-variant certainly works 
on our legacy SoCs. I'll be curious to hear your testing results.

The data sheet mentions that registers are addressed at 32-bit 
boundaries to remain consistent with the AHB bus (Section 6.1 of 
dw_apb_ssi_db.pdf).  Additionally unused bits are reserved for writes 
and 0 for reads so this seems like a good solution.

My concern is the presence of legacy devices that I have no way of 
testing. Is a Request For Test in the body of the patch sufficient?

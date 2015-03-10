From: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC/PATCHv2 3/3] spi: dw-spi: Pointers select 16b vs. 32b
 DesignWare access
Date: Tue, 10 Mar 2015 22:44:36 +0200
Message-ID: <CAHp75VcgX8WWPkHVH80eQXGAG76xSG1YpDfb24E6aWA7GZ3OZg@mail.gmail.com>
References: <1425685594-26595-1-git-send-email-tthayer@opensource.altera.com>
	<1425685594-26595-4-git-send-email-tthayer@opensource.altera.com>
	<CAHp75VcceG2O+YCw4twBzC_2v9+XQRpfBxMqGXERi3amnj3rdA@mail.gmail.com>
	<54FDDFE6.8010109@opensource.altera.com>
	<CAHp75Vf6dgobzZyJxu8eiqGgC7FRrwLCmyMf5Agk6S3jHDj4bw@mail.gmail.com>
	<54FDF8BB.4050202@opensource.altera.com>
	<CAHp75VcmNOaiyRNLFzQT7nKS6piZzpYSoS785J86rKtNXx6KNg@mail.gmail.com>
	<54FF556A.3020408@opensource.altera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>,
	Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	"ijc+devicetree" <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>,
	dinguyen <dinguyen-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org>,
	Linux Documentation List <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Thor Thayer <tthayer.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>, baruch <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>,
	Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
	Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
To: tthayer <tthayer-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <54FF556A.3020408-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Tue, Mar 10, 2015 at 10:34 PM, Thor Thayer
<tthayer-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org> wrote:
> On 03/09/2015 03:02 PM, Andy Shevchenko wrote:
>>
>> On Mon, Mar 9, 2015 at 9:47 PM, Thor Thayer
>> <tthayer-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org> wrote:
>>>
>>> On 03/09/2015 01:54 PM, Andy Shevchenko wrote:
>>
>>
>>> Yes, I just need the 32 bit write. I was trying to remain consistent but
>>> I
>>> agree that only changing only writes would minimize the changes.
>>
>>
>> Which is still makes me anxious.
>>
>> I have briefly read a chapter for SPI in pdf you sent link to. I
>> didn't find anything except SPI supports 32 bit data width.
>>
>> It would be nice if you ping your HW engineers and clarify what
>> exactly is happening there.
>>
>
> I confirmed with our HW engineer that writes are required to be 32 bits. We
> are in the process of updating our documentation to explicitly say this.
>
> Since there are no byte enables on our 32 bit APB interface, writing only 1
> or 2 bytes could corrupt the other bytes in the 32 bit word. The 32 bit
> write enforces requiring an explicit read/modify/write for less than 32 bit
> writes.
>
> Since reads are non-destructive (nothing is being written back into the
> register), it is safe for all reads to get promoted to 32 bit reads.

Thanks for detailed explanation!

> Is it preferable to have both 32 bit reads and writes for consistency?
>
> Or is it preferable to make the minimal number of changes which would be to
> only add a 32 bit write function?

Both I think just to be more clear.

However, I'm now considering what if we just replace
dw_{write/read}w() by l-variants without any additional DT property
and accessor functions?
Would it work for both your cases (old chip, new chip)?
On my side I may test this on Intel MID.

-- 
With Best Regards,
Andy Shevchenko
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

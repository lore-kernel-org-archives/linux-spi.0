From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [RFC/PATCHv2 3/3] spi: dw-spi: Pointers select 16b vs. 32b
 DesignWare access
Date: Mon, 9 Mar 2015 22:02:54 +0200
Message-ID: <CAHp75VcmNOaiyRNLFzQT7nKS6piZzpYSoS785J86rKtNXx6KNg@mail.gmail.com>
References: <1425685594-26595-1-git-send-email-tthayer@opensource.altera.com>
	<1425685594-26595-4-git-send-email-tthayer@opensource.altera.com>
	<CAHp75VcceG2O+YCw4twBzC_2v9+XQRpfBxMqGXERi3amnj3rdA@mail.gmail.com>
	<54FDDFE6.8010109@opensource.altera.com>
	<CAHp75Vf6dgobzZyJxu8eiqGgC7FRrwLCmyMf5Agk6S3jHDj4bw@mail.gmail.com>
	<54FDF8BB.4050202@opensource.altera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Mark Brown <broonie@kernel.org>,
	Grant Likely <grant.likely@linaro.org>,
	Jiri Kosina <jkosina@suse.cz>, Pawel Moll <pawel.moll@arm.com>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	ijc+devicetree@hellion.org.uk, dinguyen@opensource.altera.com,
	Linux Documentation List <linux-doc@vger.kernel.org>,
	linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
	Thor Thayer <tthayer.linux@gmail.com>,
	Axel Lin <axel.lin@ingics.com>, baruch@tkos.co.il,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jingoo Han <jg1.han@samsung.com>,
	Kumar Gala <galak@codeaurora.org>
To: tthayer@opensource.altera.com
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <54FDF8BB.4050202@opensource.altera.com>
Sender: linux-doc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Mon, Mar 9, 2015 at 9:47 PM, Thor Thayer
<tthayer@opensource.altera.com> wrote:
> On 03/09/2015 01:54 PM, Andy Shevchenko wrote:

> Yes, I just need the 32 bit write. I was trying to remain consistent but I
> agree that only changing only writes would minimize the changes.

Which is still makes me anxious.

I have briefly read a chapter for SPI in pdf you sent link to. I
didn't find anything except SPI supports 32 bit data width.

It would be nice if you ping your HW engineers and clarify what
exactly is happening there.

-- 
With Best Regards,
Andy Shevchenko

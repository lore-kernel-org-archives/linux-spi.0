From: Rajeshwari Birje <rajeshwari.birje@gmail.com>
Subject: Re: [PATCH V4] spi: s3c64xx: Enable Word transfer
Date: Tue, 29 Oct 2013 16:29:14 +0530
Message-ID: <CAPs=JDeOqkJT32quBH1tF9FtFUOt=CHP7m6ZqzhfASM2uPj-dw@mail.gmail.com>
References: <1382074356-28430-1-git-send-email-rajeshwari.s@samsung.com>
	<20131019162504.GA1863@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Rajeshwari S Shinde <rajeshwari.s@samsung.com>,
	linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
	linux-spi@vger.kernel.org, Simon Glass <sjg@chromium.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Doug Anderson <dianders@google.com>,
	Tomasz Figa <t.figa@samsung.com>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <20131019162504.GA1863@sirena.org.uk>
Sender: linux-samsung-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Mark,

On Sat, Oct 19, 2013 at 9:55 PM, Mark Brown <broonie@kernel.org> wrote:
> On Fri, Oct 18, 2013 at 11:02:36AM +0530, Rajeshwari S Shinde wrote:
>> This patch enables word transfer for s3c64xx spi driver.
>> User can set bits_per_word to 32 or 16 or 8, before calling
>> spi_setup, which would enable the corresponding transfer mode.
>
>> Change-Id: Ib04f9851a3ea891d2bfa527f2100acd314fe1c98
>
> Please don't include stuff like this in upstrem submissions, it's of no
> use to anyone outside your organisation.
That had got added by mistake. Sorry for the same.
>
> This patch is still not setting bits_per_word_mask as far as I can see?
Will send new version of patch including this.

-- 
Regards,
Rajeshwari Shinde

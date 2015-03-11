From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [RFC/PATCHv2 3/3] spi: dw-spi: Pointers select 16b vs. 32b
 DesignWare access
Date: Wed, 11 Mar 2015 12:27:16 +0200
Message-ID: <1426069636.14897.271.camel@linux.intel.com>
References: <1425685594-26595-1-git-send-email-tthayer@opensource.altera.com>
	 <1425685594-26595-4-git-send-email-tthayer@opensource.altera.com>
	 <CAHp75VcceG2O+YCw4twBzC_2v9+XQRpfBxMqGXERi3amnj3rdA@mail.gmail.com>
	 <54FDDFE6.8010109@opensource.altera.com>
	 <CAHp75Vf6dgobzZyJxu8eiqGgC7FRrwLCmyMf5Agk6S3jHDj4bw@mail.gmail.com>
	 <54FDF8BB.4050202@opensource.altera.com>
	 <CAHp75VcmNOaiyRNLFzQT7nKS6piZzpYSoS785J86rKtNXx6KNg@mail.gmail.com>
	 <54FF556A.3020408@opensource.altera.com>
	 <CAHp75VcgX8WWPkHVH80eQXGAG76xSG1YpDfb24E6aWA7GZ3OZg@mail.gmail.com>
	 <54FF6E91.1010704@opensource.altera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>,
	Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	ijc+devicetree <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>,
	dinguyen <dinguyen-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org>,
	Linux Documentation List <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Thor Thayer <tthayer.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>, baruch <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>,
	Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
	Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
To: tthayer-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <54FF6E91.1010704-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Tue, 2015-03-10 at 17:22 -0500, Thor Thayer wrote:


> > However, I'm now considering what if we just replace
> > dw_{write/read}w() by l-variants without any additional DT property
> > and accessor functions?
> > Would it work for both your cases (old chip, new chip)?
> > On my side I may test this on Intel MID.
> >
> 
> Yes, this would be the simplest solution. The l-variant certainly works 
> on our legacy SoCs. I'll be curious to hear your testing results.

Whenever you send a new version of patch.

> The data sheet mentions that registers are addressed at 32-bit 
> boundaries to remain consistent with the AHB bus (Section 6.1 of 
> dw_apb_ssi_db.pdf).  Additionally unused bits are reserved for writes 
> and 0 for reads so this seems like a good solution.
> 
> My concern is the presence of legacy devices that I have no way of 
> testing. Is a Request For Test in the body of the patch sufficient?

Better to write this wider in cover letter or (in case of one patch) in
additional description usually located after '---' line.

Since I fixed couple of bugs in core I'm not sure we have a lot of
users. Nevertheless, can you check who was recent and / or active
contributor to spi-dw-mmio.c and put him / her to Cc list.

-- 
Andy Shevchenko <andriy.shevchenko-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Intel Finland Oy

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

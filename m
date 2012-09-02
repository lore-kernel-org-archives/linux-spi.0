From: Roland Stigge <stigge@antcom.de>
Subject: Re: [PATCH v6 1/3] spi/pl022: Add chip select handling via GPIO
Date: Sun, 02 Sep 2012 22:04:14 +0200
Message-ID: <5043BBBE.30409@antcom.de>
References: <1345643359-16584-1-git-send-email-stigge@antcom.de> <CAPub14-Oot_wJsRTv2AGu3SAAf40+3_wK43=0Swxj+5XjPaDew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: linus.walleij@linaro.org, aletes.xgr@gmail.com,
	broonie@opensource.wolfsonmicro.com, grant.likely@secretlab.ca,
	rob.herring@calxeda.com, rob@landley.net,
	devicetree-discuss@lists.ozlabs.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	spi-devel-general@lists.sourceforge.net,
	gabriel.fernandez@stericsson.com, lee.jones@linaro.org,
	viresh.kumar@linaro.org, sachin.verma@st.co
To: shiraz hashim <shiraz.linux.kernel@gmail.com>
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <CAPub14-Oot_wJsRTv2AGu3SAAf40+3_wK43=0Swxj+5XjPaDew@mail.gmail.com>
Sender: linux-doc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Shiraz,

On 01/09/12 13:14, shiraz hashim wrote:
> On Wed, Aug 22, 2012 at 7:19 PM, Roland Stigge <stigge@antcom.de> wrote:
>> @@ -2016,6 +2030,8 @@ pl022_probe(struct amba_device *adev, co
>>         pl022->master_info = platform_info;
>>         pl022->adev = adev;
>>         pl022->vendor = id->data;
>> +       /* Point chipselects to allocated memory beyond the main struct */
>> +       pl022->chipselects = (int *) pl022 + sizeof(struct pl022);
> 
> This is going beyond memory allocated for chipselects
> as it adds 4 * sizeof(struct pl022) bytes to pl022.
> 
> pl022->chipselects = (int *) &pl022[1];

Correct. Thanks for the heads up!

Funnily, my previous proposal way actually like you just proposed, but
we took the other one since it looked "better". ;-)

I'll provide an incremental bugfix patch since Mark already has the
commit in his misc.git tree.

Thanks again,

Roland

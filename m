From: Baolin Wang <baolin.wang@linaro.org>
Subject: Re: [PATCH 6/6] dt-bindings: spi: sprd: Change the hwlock support to
 be optional
Date: Fri, 26 Jul 2019 20:10:02 +0800
Message-ID: <CAMz4ku+3FVOYr7Gvh-Yrdhvw2cfntbnEkhONYGbC71UmCgZA-A@mail.gmail.com>
References: <cover.1564125131.git.baolin.wang@linaro.org> <23d51f5d9c9cc647ad0c5a1fb950d3d9fb9c1303.1564125131.git.baolin.wang@linaro.org>
 <20190726112901.GC4902@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>, weicx@spreadst.com,
        sherry.zong@unisoc.com,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190726112901.GC4902@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Mark,

On Fri, 26 Jul 2019 at 19:29, Mark Brown <broonie@kernel.org> wrote:
>
> On Fri, Jul 26, 2019 at 03:20:53PM +0800, Baolin Wang wrote:
> > No need to add hardware spinlock proctection due to add multiple
> > msater channel, so change it to be optional in documentation.
>
> Please use subject lines matching the style for the subsystem.  This
> makes it easier for people to identify relevant patches.

The subject lines format 'dt-bindings: xxx' was recommended by Rob, so
I am not sure if I need to change the format as 'spi: sprd:'? Thanks.

-- 
Baolin Wang
Best Regards

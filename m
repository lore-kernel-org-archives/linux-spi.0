From: Laxman Dewangan <ldewangan@nvidia.com>
Subject: Re: [PATCH] spi: tegra20-slink: use true and false for boolean values
Date: Tue, 6 Mar 2018 11:16:24 +0530
Message-ID: <68fcf8c2-e312-eb76-09db-73d2b040b33a@nvidia.com>
References: <20180305235339.GA646@embeddedgus>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Cc: <linux-spi@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Mark Brown <broonie@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        "Jonathan Hunter" <jonathanh@nvidia.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180305235339.GA646@embeddedgus>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org



On Tuesday 06 March 2018 05:23 AM, Gustavo A. R. Silva wrote:
> Assign true or false to boolean variables instead of an integer value.
>
> This issue was detected with the help of Coccinelle.
>
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
>

Acked-by: Laxman Dewangan <ldewangan@nvidia.com>

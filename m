From: Jon Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH V5 1/4] spi: tegra114: add support for gpio based CS
Date: Tue, 14 May 2019 10:33:40 +0100
Message-ID: <cf4bd167-49b8-5649-a2e2-7bf5ddcc6e2d@nvidia.com>
References: <1557810235-16401-1-git-send-email-skomatineni@nvidia.com>
 <1557810235-16401-2-git-send-email-skomatineni@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>
To: Sowjanya Komatineni <skomatineni@nvidia.com>,
        <thierry.reding@gmail.com>, <ldewangan@nvidia.com>,
        <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1557810235-16401-2-git-send-email-skomatineni@nvidia.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


On 14/05/2019 06:03, Sowjanya Komatineni wrote:
> This patch adds support for GPIO based CS control through SPI core
> function spi_set_cs.
> 
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
Can you elaborate on the use-case where this is needed? I am curious
what platforms are using this and why they would not use the dedicated
CS signals.

Cheers
Jon

-- 
nvpublic

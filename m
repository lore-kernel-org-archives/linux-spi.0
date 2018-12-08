From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH V3 1/4] spi: lpspi: Replace all "master" with
 "controller"
Date: Fri, 07 Dec 2018 21:14:12 -0800
Message-ID: <1bb3bde9a47a3ca8a026fab9e6af420c1ae59f97.camel@perches.com>
References: <20181207024924.6315-1-xiaoning.wang@nxp.com>
         <20181207024924.6315-2-xiaoning.wang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
To: Clark Wang <xiaoning.wang@nxp.com>,
        "broonie@kernel.org" <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181207024924.6315-2-xiaoning.wang@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Fri, 2018-12-07 at 02:50 +0000, Clark Wang wrote:
> In order to enable the slave mode and make the code more readable,
> replace all related structure names and object names which is
> named "master" with "controller".

In what sense does this make the code more readable?

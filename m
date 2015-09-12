From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH v2] ARM: pxa: ssp: Fix build error by removing originally
 incorrect DT binding
Date: Sat, 12 Sep 2015 15:43:09 +0200
Message-ID: <87zj0rsqhe.fsf@belgarion.home>
References: <1441610581-11434-1-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Russell King <linux@arm.linux.org.uk>,
 Haojian Zhuang <haojian.zhuang@gmail.com>, linux-spi@vger.kernel.org,
 Mark Brown <broonie@kernel.org>, linux-arm-kernel@lists.infradead.org,
 stable@vger.kernel.org, Daniel Mack <daniel@zonque.org>
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1441610581-11434-1-git-send-email-jarkko.nikula@linux.intel.com>
 (Jarkko Nikula's message of "Mon, 7 Sep 2015 10:23:01 +0300")
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

Jarkko Nikula <jarkko.nikula@linux.intel.com> writes:

> Commit 03fbf488cece ("spi: pxa2xx: Differentiate Intel LPSS types") caused
> build error here because it removed the type LPSS_SSP and I didn't notice
> the type was used here too.
>
> I believe commit a6e56c28a178 ("ARM: pxa: ssp: add DT bindings") added it
> accidentally by copying all enum pxa_ssp_type types from
> include/linux/pxa2xx_ssp.h even LPSS_SSP was for Intel LPSS SPI devices.
>
> Fix the build error by removing this incorrect binding.
>
> Fixes: 03fbf488cece ("spi: pxa2xx: Differentiate Intel LPSS types")
> Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
> Reported-by: Axel Lin <axel.lin@ingics.com>
> Cc: <stable@vger.kernel.org> # 4.2
> ---
> v2: Added Fixes tag suggested by Robert Jarzmik

Queued into pxa/fixes, thanks.

Cheers.

--
Robert

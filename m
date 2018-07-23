From: dkota@codeaurora.org
Subject: Re: [PATCH V2] spi: spi-geni-qcom: Add SPI driver support for GENI
 based QUP
Date: Mon, 23 Jul 2018 15:57:04 +0530
Message-ID: <891441f9f95f5d1f387cb9ffb9df1515@codeaurora.org>
References: <1532087461-3474-2-git-send-email-dkota@codeaurora.org>
 <201807210707.BLvlaScm%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
To: kbuild-all@01.org, timur@codeaurora.org, swboyd@chromium.org,
        broonie@kernel.org, mka@chromium.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Doug Anderson <dianders@chromium.org>, alokc@codeaurora.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201807210707.BLvlaScm%fengguang.wu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 2018-07-21 05:07, kbuild test robot wrote:
> Hi Girish,
> 
> Thank you for the patch! Yet something to improve:
> 
> [auto build test ERROR on spi/for-next]
> [also build test ERROR on v4.18-rc5 next-20180720]
> [if your patch is applied to the wrong git tree, please drop us a note
> to help improve the system]
> 
> url:
> https://github.com/0day-ci/linux/commits/Dilip-Kota/spi-spi-geni-qcom-Add-SPI-driver-support-for-GENI-based-QUP/20180721-034916
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 
> for-next
> config: ia64-allmodconfig (attached as .config)
> compiler: ia64-linux-gcc (GCC) 8.1.0
> reproduce:
>         wget
> https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross
> -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         GCC_VERSION=8.1.0 make.cross ARCH=ia64
> 
> All errors (new ones prefixed by >>):
> 
>    In file included from drivers/spi/spi-geni-qcom.c:11:
>    drivers/spi/spi-geni-qcom.c: In function
> 'spi_geni_prepare_transfer_hardware':
>>> include/linux/qcom-geni-se.h:238:9: error: 'version' undeclared 
>>> (first use in this function); did you mean 'vm_region'?
>      step = version & HW_VER_STEP_MASK; \
>             ^~~~~~~
>    drivers/spi/spi-geni-qcom.c:256:3: note: in expansion of macro
> 'geni_se_get_wrapper_version'
>       geni_se_get_wrapper_version(se, major, minor, step);
>       ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/qcom-geni-se.h:238:9: note: each undeclared
> identifier is reported only once for each function it appears in
>      step = version & HW_VER_STEP_MASK; \
>             ^~~~~~~
>    drivers/spi/spi-geni-qcom.c:256:3: note: in expansion of macro
> 'geni_se_get_wrapper_version'
>       geni_se_get_wrapper_version(se, major, minor, step);
>       ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> --
>    In file included from drivers//spi/spi-geni-qcom.c:11:
>    drivers//spi/spi-geni-qcom.c: In function
> 'spi_geni_prepare_transfer_hardware':
>>> include/linux/qcom-geni-se.h:238:9: error: 'version' undeclared 
>>> (first use in this function); did you mean 'vm_region'?
>      step = version & HW_VER_STEP_MASK; \
>             ^~~~~~~
>    drivers//spi/spi-geni-qcom.c:256:3: note: in expansion of macro
> 'geni_se_get_wrapper_version'
>       geni_se_get_wrapper_version(se, major, minor, step);
>       ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/qcom-geni-se.h:238:9: note: each undeclared
> identifier is reported only once for each function it appears in
>      step = version & HW_VER_STEP_MASK; \
>             ^~~~~~~
>    drivers//spi/spi-geni-qcom.c:256:3: note: in expansion of macro
> 'geni_se_get_wrapper_version'
>       geni_se_get_wrapper_version(se, major, minor, step);
>       ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> vim +238 include/linux/qcom-geni-se.h
> 
> eddac5af Karthikeyan Ramasubramanian 2018-03-30  231
> eddac5af Karthikeyan Ramasubramanian 2018-03-30  232  #define
> geni_se_get_wrapper_version(se, major, minor, step) do { \
> eddac5af Karthikeyan Ramasubramanian 2018-03-30  233  	u32 ver; \
> eddac5af Karthikeyan Ramasubramanian 2018-03-30  234  \
> eddac5af Karthikeyan Ramasubramanian 2018-03-30  235  	ver =
> geni_se_get_qup_hw_version(se); \
> eddac5af Karthikeyan Ramasubramanian 2018-03-30  236  	major = (ver &
> HW_VER_MAJOR_MASK) >> HW_VER_MAJOR_SHFT; \
> eddac5af Karthikeyan Ramasubramanian 2018-03-30  237  	minor = (ver &
> HW_VER_MINOR_MASK) >> HW_VER_MINOR_SHFT; \
> eddac5af Karthikeyan Ramasubramanian 2018-03-30 @238  	step = version
> & HW_VER_STEP_MASK; \
> eddac5af Karthikeyan Ramasubramanian 2018-03-30  239  } while (0)
> eddac5af Karthikeyan Ramasubramanian 2018-03-30  240
> 
> :::::: The code at line 238 was first introduced by commit
> :::::: eddac5af06546d2e7a0730e3dc02dde3dc91098a soc: qcom: Add GENI
> based QUP Wrapper driver
> 
> :::::: TO: Karthikeyan Ramasubramanian <kramasub@codeaurora.org>
> :::::: CC: Andy Gross <andy.gross@linaro.org>
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology 
> Center
> https://lists.01.org/pipermail/kbuild-all                   Intel 
> Corporation


HI,

For now please ignore the PATCHSET 2. I will upload a new PATCHSET 
addressing all the comments of patchset 1 with detailed description.
Sorry for the inconvenience.

Regards,
Dilip

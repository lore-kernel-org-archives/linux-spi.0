From: Billy Laws <blaws05@gmail.com>
Subject: Re: [PATCH V1 00/12] LP0 entry and exit support for Tegra210
Date: Tue, 28 May 2019 10:28:48 +0100
Message-ID: <CAFUUQHP5e=oQZC29foYD+uA96r5-M4wCxKYVL_LodrWRG5kp1Q@mail.gmail.com>
References: <1558574922-16531-1-git-send-email-skomatineni@nvidia.com> <0418cbdb-1bb6-23c3-f13d-e0a70f899f3c@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: thierry.reding@gmail.com, jonathanh@nvidia.com,
        Laxman Dewangan <ldewangan@nvidia.com>, broonie@kernel.org,
        natechancellor@gmail.com, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
To: Sowjanya Komatineni <skomatineni@nvidia.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <0418cbdb-1bb6-23c3-f13d-e0a70f899f3c@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi,
By the looks of this you configure wake events but the pmc driver
still only configures lp1, which is the same as linux 4 tegra 4.4+
which also doesn't support lp0, if its selected in dts it'll just
change it to LP1/SC7 (both have same code path and neither set any lp0
stuff trm says). What confuses me further is that l4t and this
ptachset both configure wake events, which I think should only work in
LP0 and not LP1 and yet neither have lp0 entry code for t210. I also
looked at ATF, whis sets the flags to wake the cpu on interrupts,
which would suggest that it only supports lp1 (in deep sleep I dont
think them flags would work). Am I missing some important detail here?
Two other things, will you be adding full lp0 in later patchets and
will they use the bpmp or not?

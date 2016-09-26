From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH 0/2] Moving runnable code from Documentation (last 2 patches)
Date: Mon, 26 Sep 2016 11:44:03 -0700
Message-ID: <CAGXu5j+eYRB+Kdyr0g6UG8_GFJz4dJ+VNsGVvnRtShn1pRT58g@mail.gmail.com>
References: <cover.1474912582.git.shuahkh@osg.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Corbet <corbet@lwn.net>, Michal Marek <mmarek@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Tejun Heo <tj@kernel.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Nikolay Aleksandrov <nikolay@cumulusnetworks.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        "Nicholas A. Bellinger" <nab@linux-iscsi.org>, mchehab@kernel.org,
        Mark Brown <broonie@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, ecree@solarflare.com,
        "David S. Miller" <davem@davemloft.net>,
To: Shuah Khan <shuahkh@osg.samsung.com>
Return-path: <linux-kbuild-owner@vger.kernel.org>
In-Reply-To: <cover.1474912582.git.shuahkh@osg.samsung.com>
Sender: linux-kbuild-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Mon, Sep 26, 2016 at 11:40 AM, Shuah Khan <shuahkh@osg.samsung.com> wrote:
> This patch series contains the last 2 patches to complete moving runnable
> code from Documentation to selftests, samples, and tools.
>
> The first patch moves blackfin gptimers-example to samples and removes
> CONFIG_BUILD_DOCSRC.
>
> The second one updates 00-INDEX files under Documentation to reflect the
> move of runnable code from Documentation.

Looks good to me!

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

-- 
Kees Cook
Nexus Security

<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>AI未来引擎创新马拉松 | 2026</title>
    
    <!-- Tailwind CSS -->
    <script src="https://cdn.tailwindcss.com"></script>
    
    <!-- Google Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800;900&family=Orbitron:wght@400;500;600;700;800;900&family=Noto+Sans+SC:wght@300;400;500;600;700;900&display=swap" rel="stylesheet">
    
    <!-- GSAP -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/gsap/3.12.2/gsap.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/gsap/3.12.2/ScrollTrigger.min.js"></script>
    
    <!-- Lenis Smooth Scroll -->
    <script src="https://unpkg.com/lenis@1.0.42/dist/lenis.min.js"></script>
    
    <!-- Custom Tailwind Config -->
    <script>
        tailwind.config = {
            darkMode: 'class',
            theme: {
                extend: {
                    fontFamily: {
                        sans: ['Inter', 'Noto Sans SC', 'sans-serif'],
                        display: ['Orbitron', 'sans-serif'],
                    },
                    colors: {
                        dark: '#050505',
                        'deep-space': '#0a0a1f',
                        'neural-blue': '#00d4ff',
                        'neural-purple': '#a855f7',
                        'neural-pink': '#ec4899',
                        'neural-green': '#10b981',
                    },
                    backgroundImage: {
                        'neural-gradient': 'linear-gradient(135deg, #00d4ff 0%, #a855f7 50%, #ec4899 100%)',
                        'cyber-grid': 'linear-gradient(rgba(0, 212, 255, 0.03) 1px, transparent 1px), linear-gradient(90deg, rgba(0, 212, 255, 0.03) 1px, transparent 1px)',
                    },
                    animation: {
                        'pulse-slow': 'pulse 4s cubic-bezier(0.4, 0, 0.6, 1) infinite',
                        'float': 'float 6s ease-in-out infinite',
                        'glow': 'glow 2s ease-in-out infinite alternate',
                    },
                    keyframes: {
                        float: {
                            '0%, 100%': { transform: 'translateY(0)' },
                            '50%': { transform: 'translateY(-20px)' },
                        },
                        glow: {
                            '0%': { boxShadow: '0 0 5px #00d4ff, 0 0 10px #00d4ff, 0 0 15px #00d4ff' },
                            '100%': { boxShadow: '0 0 2px #00d4ff, 0 0 5px #00d4ff, 0 0 10px #00d4ff' },
                        }
                    }
                }
            }
        }
    </script>
    
    <style>
        :root {
            --neural-gradient: linear-gradient(135deg, #00d4ff 0%, #a855f7 50%, #ec4899 100%);
            --cyber-blue: rgba(0, 212, 255, 0.1);
            --cyber-purple: rgba(168, 85, 247, 0.1);
        }
        
        body {
            background-color: #050505;
            color: #f5f5f5;
            overflow-x: hidden;
            -webkit-font-smoothing: antialiased;
            -moz-osx-font-smoothing: grayscale;
        }
        
        /* 网格背景 */
        .cyber-grid {
            background-image: 
                linear-gradient(rgba(0, 212, 255, 0.03) 1px, transparent 1px),
                linear-gradient(90deg, rgba(0, 212, 255, 0.03) 1px, transparent 1px);
            background-size: 50px 50px;
        }
        
        /* 噪点纹理 */
        .noise-overlay {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            pointer-events: none;
            z-index: 9999;
            opacity: 0.02;
            background-image: url("data:image/svg+xml,%3Csvg viewBox='0 0 200 200' xmlns='http://www.w3.org/2000/svg'%3E%3Cfilter id='noiseFilter'%3E%3CfeTurbulence type='fractalNoise' baseFrequency='0.65' numOctaves='3' stitchTiles='stitch'/%3E%3C/filter%3E%3Crect width='100%25' height='100%25' filter='url(%23noiseFilter)'/%3E%3C/svg%3E");
        }
        
        /* 自定义滚动条 */
        ::-webkit-scrollbar {
            width: 8px;
        }
        ::-webkit-scrollbar-track {
            background: #050505;
        }
        ::-webkit-scrollbar-thumb {
            background: #333;
            border-radius: 4px;
        }
        ::-webkit-scrollbar-thumb:hover {
            background: #00d4ff;
        }
        
        /* 玻璃拟态 */
        .glass {
            background: rgba(255, 255, 255, 0.03);
            backdrop-filter: blur(10px);
            -webkit-backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.08);
        }
        
        /* 磁性按钮 */
        .magnetic-btn {
            transition: transform 0.3s cubic-bezier(0.25, 0.46, 0.45, 0.94);
        }
        
        /* 渐变文字 */
        .text-gradient {
            background: var(--neural-gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }
        
        /* 卡片悬停3D效果 */
        .card-3d {
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            transform-style: preserve-3d;
        }
        .card-3d:hover {
            transform: translateY(-10px) rotateX(5deg) rotateY(5deg);
            box-shadow: 0 20px 40px rgba(0, 212, 255, 0.2);
        }
        
        /* 动态阴影 */
        .dynamic-shadow {
            transition: box-shadow 0.3s ease;
        }
        .dynamic-shadow:hover {
            box-shadow: 0 0 30px rgba(168, 85, 247, 0.3);
        }
        
        /* 神经网络画布 */
        #neural-canvas {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            z-index: -1;
            pointer-events: none;
        }
        
        /* 加载动画 */
        .loader {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: #050505;
            display: flex;
            justify-content: center;
            align-items: center;
            z-index: 10000;
            transition: opacity 0.5s ease;
        }
        .loader.hidden {
            opacity: 0;
            pointer-events: none;
        }
        .loader-text {
            font-family: 'Orbitron', sans-serif;
            font-size: 2.5rem;
            font-weight: 700;
            letter-spacing: 0.2em;
            background: var(--neural-gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            animation: pulse 1.5s infinite;
        }
        
        /* 导航链接下划线动画 */
        .nav-link {
            position: relative;
        }
        .nav-link::after {
            content: '';
            position: absolute;
            bottom: -2px;
            left: 0;
            width: 0;
            height: 2px;
            background: var(--neural-gradient);
            transition: width 0.3s ease;
        }
        .nav-link:hover::after {
            width: 100%;
        }
        
        /* 时间线样式 */
        .timeline-item {
            position: relative;
            padding-left: 2rem;
        }
        .timeline-item::before {
            content: '';
            position: absolute;
            left: 0;
            top: 0;
            bottom: 0;
            width: 2px;
            background: var(--neural-gradient);
            opacity: 0.3;
        }
        .timeline-dot {
            position: absolute;
            left: -5px;
            top: 0;
            width: 12px;
            height: 12px;
            border-radius: 50%;
            background: #00d4ff;
            border: 2px solid #050505;
            box-shadow: 0 0 10px #00d4ff;
        }
        
        /* 奖项卡片 */
        .prize-card {
            background: linear-gradient(135deg, rgba(0, 212, 255, 0.05) 0%, rgba(168, 85, 247, 0.05) 100%);
            border: 1px solid rgba(0, 212, 255, 0.2);
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
        }
        .prize-card::before {
            content: '';
            position: absolute;
            top: -50%;
            left: -50%;
            width: 200%;
            height: 200%;
            background: radial-gradient(circle, rgba(0, 212, 255, 0.1) 0%, transparent 70%);
            opacity: 0;
            transition: opacity 0.3s ease;
        }
        .prize-card:hover::before {
            opacity: 1;
        }
        .prize-card:hover {
            transform: translateY(-5px);
            border-color: rgba(0, 212, 255, 0.5);
            box-shadow: 0 10px 30px rgba(0, 212, 255, 0.2);
        }
        .prize-amount {
            font-family: 'Orbitron', sans-serif;
            font-size: 2.5rem;
            font-weight: 700;
            background: var(--neural-gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }
        
        /* 光标跟随 */
        .cursor-glow {
            position: fixed;
            width: 400px;
            height: 400px;
            background: radial-gradient(circle, rgba(0, 212, 255, 0.1) 0%, rgba(168, 85, 247, 0.05) 50%, transparent 70%);
            border-radius: 50%;
            pointer-events: none;
            z-index: 1;
            transform: translate(-50%, -50%);
            transition: opacity 0.3s ease;
            mix-blend-mode: screen;
        }
        
        /* 流动数据背景 */
        .data-stream {
            position: absolute;
            font-family: 'Courier New', monospace;
            font-size: 10px;
            color: rgba(0, 212, 255, 0.3);
            white-space: nowrap;
            animation: data-flow 20s linear infinite;
        }
        
        @keyframes data-flow {
            0% { transform: translateY(-100%); }
            100% { transform: translateY(100vh); }
        }
    </style>
</head>
<body class="selection:bg-neural-blue selection:text-black">
    <!-- 噪点纹理 -->
    <div class="noise-overlay"></div>
    
    <!-- 光标跟随 -->
    <div class="cursor-glow" id="cursorGlow"></div>
    
    <!-- 神经网络背景 -->
    <canvas id="neural-canvas"></canvas>
    
    <!-- 加载动画 -->
    <div class="loader" id="loader">
        <div class="loader-text">AI未来引擎</div>
    </div>
    
    <!-- 导航栏 -->
    <nav class="fixed top-0 left-0 right-0 z-50 glass px-6 py-4 transition-all duration-300" id="navbar">
        <div class="max-w-7xl mx-auto flex justify-between items-center">
            <a href="#" class="text-2xl font-display font-bold tracking-tight">
                <span class="text-gradient">AI</span>未来引擎
            </a>
            <div class="hidden md:flex space-x-8">
                <a href="#home" class="nav-link text-sm font-medium text-gray-300 hover:text-white">首页</a>
                <a href="#about" class="nav-link text-sm font-medium text-gray-300 hover:text-white">关于大赛</a>
                <a href="#schedule" class="nav-link text-sm font-medium text-gray-300 hover:text-white">赛程与奖项</a>
                <a href="#register" class="nav-link text-sm font-medium text-gray-300 hover:text-white">立即报名</a>
            </div>
            <button class="magnetic-btn px-6 py-2 rounded-full bg-gradient-to-r from-neural-blue to-neural-purple text-white text-sm font-semibold hover:shadow-lg hover:shadow-neural-blue/30 transition-all dynamic-shadow">
                立即参赛
            </button>
        </div>
    </nav>
    
    <!-- 主内容 -->
    <main class="relative z-10">
        <!-- Hero Section -->
        <section id="home" class="min-h-screen flex items-center justify-center px-6 pt-20 relative cyber-grid">
            <!-- 流动数据装饰 -->
            <div class="data-stream absolute left-10" style="top: -20%;">01001000 01110101 01100001 01101011 00100000 01010100 01101111 01101110</div>
            <div class="data-stream absolute right-20" style="top: -30%; animation-delay: -5s;">01000001 01000001 01000001 01000001 01000001 01000001 01000001</div>
            <div class="data-stream absolute left-1/3" style="top: -40%; animation-delay: -10s;">01111001 01100001 01101001 01101110 00100000 01110100 01110101</div>
            
            <div class="max-w-7xl mx-auto text-center">
                <div class="overflow-hidden mb-6">
                    <p class="text-neural-blue text-sm md:text-base font-medium tracking-widest uppercase reveal-text">
                        AI Innovation Marathon 2026
                    </p>
                </div>
                <h1 class="text-5xl md:text-7xl lg:text-9xl font-display font-bold leading-tight mb-8">
                    <span class="block reveal-text">AI未来引擎</span>
                    <span class="block text-gradient reveal-text">创新马拉松</span>
                </h1>
                <p class="text-gray-400 text-lg md:text-xl max-w-3xl mx-auto mb-12 leading-relaxed reveal-text">
                    汇聚全球顶尖AI人才，探索人工智能的无限可能。用代码改变世界，用智能创造未来。
                </p>
                <div class="flex flex-col sm:flex-row gap-4 justify-center reveal-text">
                    <button class="magnetic-btn px-8 py-4 rounded-full bg-gradient-to-r from-neural-blue to-neural-purple text-white font-bold text-lg hover:shadow-lg hover:shadow-neural-blue/30 transition-all dynamic-shadow">
                        立即报名参赛
                    </button>
                    <button class="magnetic-btn px-8 py-4 rounded-full glass text-white font-semibold text-lg hover:bg-white/10 transition-all">
                        了解更多
                    </button>
                </div>
                
                <!-- 奖池展示 -->
                <div class="mt-20 reveal-text">
                    <p class="text-gray-500 text-sm mb-4">总奖池</p>
                    <div class="text-6xl md:text-8xl font-display font-bold text-gradient">
                        ¥1,100,000
                    </div>
                </div>
            </div>
            
            <!-- 滚动提示 -->
            <div class="absolute bottom-10 left-1/2 -translate-x-1/2 animate-bounce">
                <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                    <path d="M12 5v14M19 12l-7 7-7-7"/>
                </svg>
            </div>
        </section>
        
        <!-- About Section -->
        <section id="about" class="py-32 px-6">
            <div class="max-w-7xl mx-auto">
                <div class="mb-20">
                    <h2 class="text-4xl md:text-6xl font-display font-bold mb-6 reveal-section">
                        关于大赛
                    </h2>
                    <div class="grid md:grid-cols-2 gap-12 items-center">
                        <p class="text-gray-300 text-lg leading-relaxed reveal-section">
                            我们相信，AI是驱动未来商业与社会进步的核心引擎。本次创新马拉松旨在汇聚最具创造力的头脑，将前沿的AI技术转化为切实可行的商业解决方案或高效的服务工具，共同塑造智能化的未来。
                        </p>
                        <div class="grid grid-cols-2 gap-4 reveal-section">
                            <div class="bento-card bg-gray-900 p-6 border border-gray-800">
                                <div class="text-3xl font-bold text-neural-blue mb-2">48h</div>
                                <div class="text-gray-400 text-sm">极限编程挑战</div>
                            </div>
                            <div class="bento-card bg-gray-900 p-6 border border-gray-800">
                                <div class="text-3xl font-bold text-neural-purple mb-2">100+</div>
                                <div class="text-gray-400 text-sm">预计参赛团队</div>
                            </div>
                            <div class="bento-card bg-gray-900 p-6 border border-gray-800 col-span-2">
                                <div class="text-gray-400 text-sm mb-2">核心赛道</div>
                                <div class="flex flex-wrap gap-2">
                                    <span class="px-3 py-1 bg-gray-800 rounded-full text-xs">AI技术探索</span>
                                    <span class="px-3 py-1 bg-gray-800 rounded-full text-xs">业务流程自动化</span>
                                    <span class="px-3 py-1 bg-gray-800 rounded-full text-xs">AI SaaS服务</span>
                                    <span class="px-3 py-1 bg-gray-800 rounded-full text-xs">智能决策系统</span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- Bento Grid -->
                <div class="grid md:grid-cols-3 gap-6">
                    <div class="bento-card md:col-span-2 bg-gray-900 p-8 border border-gray-800 h-96 relative overflow-hidden reveal-section">
                        <div class="absolute top-0 right-0 w-64 h-64 bg-neural-blue/20 rounded-full blur-3xl -translate-y-1/2 translate-x-1/2"></div>
                        <h3 class="text-2xl font-bold mb-4">评审机制</h3>
                        <p class="text-gray-400 leading-relaxed mb-6">
                            采用"参赛团队投票（占30%）+ 专家评委评审（占70%）"的混合模式，确保公平公正。评委团由来自顶级科技公司、投资机构和学术界的专家组成。
                        </p>
                        <div class="flex items-center space-x-4">
                            <div class="text-center">
                                <div class="text-3xl font-bold text-neural-blue">30%</div>
                                <div class="text-xs text-gray-500">团队投票</div>
                            </div>
                            <div class="w-px h-12 bg-gray-700"></div>
                            <div class="text-center">
                                <div class="text-3xl font-bold text-neural-purple">70%</div>
                                <div class="text-xs text-gray-500">专家评审</div>
                            </div>
                        </div>
                    </div>
                    <div class="bento-card bg-gray-900 p-8 border border-gray-800 h-96 relative overflow-hidden reveal-section">
                        <div class="absolute bottom-0 left-0 w-48 h-48 bg-neural-purple/20 rounded-full blur-3xl translate-y-1/2 -translate-x-1/2"></div>
                        <h3 class="text-2xl font-bold mb-4">参赛费用</h3>
                        <div class="text-4xl font-display font-bold text-neural-pink mb-4">¥5,000</div>
                        <p class="text-gray-400 text-sm leading-relaxed">
                            每支参赛队伍（无论个人、团队或公司形式）需缴纳人民币5,000元的参赛费，用于活动组织、评审费用及物料支持。
                        </p>
                    </div>
                </div>
            </div>
        </section>
        
        <!-- Schedule & Prizes Section -->
        <section id="schedule" class="py-32 px-6 bg-gray-900/30">
            <div class="max-w-7xl mx-auto">
                <div class="text-center mb-20">
                    <h2 class="text-4xl md:text-6xl font-display font-bold mb-6 reveal-section">
                        赛程与奖项
                    </h2>
                    <p class="text-gray-400 max-w-2xl mx-auto reveal-section">
                        把握时间节点，规划你的创新之路。丰厚奖金等你来战！
                    </p>
                </div>
                
                <!-- 时间线 -->
                <div class="mb-20 reveal-section">
                    <div class="max-w-3xl mx-auto">
                        <div class="timeline-item mb-8">
                            <div class="timeline-dot"></div>
                            <div class="glass rounded-lg p-6">
                                <div class="text-neural-blue font-semibold mb-2">2026年3月1日</div>
                                <h3 class="text-xl font-bold mb-2">报名启动</h3>
                                <p class="text-gray-400 text-sm">官网与报名通道正式开放，开始提交参赛申请。</p>
                            </div>
                        </div>
                        <div class="timeline-item mb-8">
                            <div class="timeline-dot"></div>
                            <div class="glass rounded-lg p-6">
                                <div class="text-neural-blue font-semibold mb-2">2026年4月15日</div>
                                <h3 class="text-xl font-bold mb-2">报名截止</h3>
                                <p class="text-gray-400 text-sm">停止接收参赛申请，请在此之前完成报名和缴费。</p>
                            </div>
                        </div>
                        <div class="timeline-item mb-8">
                            <div class="timeline-dot"></div>
                            <div class="glass rounded-lg p-6">
                                <div class="text-neural-blue font-semibold mb-2">2026年5月10日</div>
                                <h3 class="text-xl font-bold mb-2">初赛（线上）</h3>
                                <p class="text-gray-400 text-sm">提交项目方案，由评委进行初审，选出决赛团队。</p>
                            </div>
                        </div>
                        <div class="timeline-item mb-8">
                            <div class="timeline-dot"></div>
                            <div class="glass rounded-lg p-6">
                                <div class="text-neural-blue font-semibold mb-2">2026年6月20日</div>
                                <h3 class="text-xl font-bold mb-2">决赛名单公布</h3>
                                <p class="text-gray-400 text-sm">公布进入决赛的团队，准备路演材料。</p>
                            </div>
                        </div>
                        <div class="timeline-item">
                            <div class="timeline-dot"></div>
                            <div class="glass rounded-lg p-6 border-neural-blue/50">
                                <div class="text-neural-blue font-semibold mb-2">2026年7月15日</div>
                                <h3 class="text-xl font-bold mb-2">决赛路演暨颁奖典礼</h3>
                                <p class="text-gray-400 text-sm">现场展示与答辩，公布最终获奖名单，颁发奖金和证书。</p>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- 奖项展示 -->
                <div class="grid md:grid-cols-2 lg:grid-cols-4 gap-6">
                    <!-- 特等奖 -->
                    <div class="prize-card rounded-2xl p-6 reveal-section" style="animation-delay: 0.1s">
                        <div class="text-neural-blue text-sm font-medium mb-2">特等奖</div>
                        <div class="prize-amount mb-4">¥500,000</div>
                        <div class="text-gray-400 text-sm mb-4">仅1名</div>
                        <div class="space-y-2">
                            <div class="flex items-center text-xs text-gray-300">
                                <svg class="w-4 h-4 mr-2 text-neural-blue" fill="currentColor" viewBox="0 0 20 20"><path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd"/></svg>
                                冠军称号
                            </div>
                            <div class="flex items-center text-xs text-gray-300">
                                <svg class="w-4 h-4 mr-2 text-neural-blue" fill="currentColor" viewBox="0 0 20 20"><path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd"/></svg>
                                独家创业孵化指导
                            </div>
                            <div class="flex items-center text-xs text-gray-300">
                                <svg class="w-4 h-4 mr-2 text-neural-blue" fill="currentColor" viewBox="0 0 20 20"><path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd"/></svg>
                                全球媒体专访
                            </div>
                            <div class="flex items-center text-xs text-gray-300">
                                <svg class="w-4 h-4 mr-2 text-neural-blue" fill="currentColor" viewBox="0 0 20 20"><path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd"/></svg>
                                合作企业直通面试
                            </div>
                        </div>
                    </div>
                    
                    <!-- 一等奖 -->
                    <div class="prize-card rounded-2xl p-6 reveal-section" style="animation-delay: 0.2s">
                        <div class="text-neural-purple text-sm font-medium mb-2">一等奖</div>
                        <div class="prize-amount mb-4">¥250,000</div>
                        <div class="text-gray-400 text-sm mb-4">仅1名</div>
                        <div class="space-y-2">
                            <div class="flex items-center text-xs text-gray-300">
                                <svg class="w-4 h-4 mr-2 text-neural-purple" fill="currentColor" viewBox="0 0 20 20"><path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd"/></svg>
                                卓越创新奖
                            </div>
                            <div class="flex items-center text-xs text-gray-300">
                                <svg class="w-4 h-4 mr-2 text-neural-purple" fill="currentColor" viewBox="0 0 20 20"><path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd"/></svg>
                                行业领袖导师计划
                            </div>
                            <div class="flex items-center text-xs text-gray-300">
                                <svg class="w-4 h-4 mr-2 text-neural-purple" fill="currentColor" viewBox="0 0 20 20"><path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd"/></svg>
                                合作企业实习名额
                            </div>
                        </div>
                    </div>
                    
                    <!-- 二等奖 -->
                    <div class="prize-card rounded-2xl p-6 reveal-section" style="animation-delay: 0.3s">
                        <div class="text-neural-pink text-sm font-medium mb-2">二等奖</div>
                        <div class="prize-amount mb-4">¥150,000</div>
                        <div class="text-gray-400 text-sm mb-4">2名</div>
                        <div class="space-y-2">
                            <div class="flex items-center text-xs text-gray-300">
                                <svg class="w-4 h-4 mr-2 text-neural-pink" fill="currentColor" viewBox="0 0 20 20"><path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd"/></svg>
                                杰出贡献奖
                            </div>
                            <div class="flex items-center text-xs text-gray-300">
                                <svg class="w-4 h-4 mr-2 text-neural-pink" fill="currentColor" viewBox="0 0 20 20"><path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd"/></svg>
                                云服务资源包（1年）
                            </div>
                            <div class="flex items-center text-xs text-gray-300">
                                <svg class="w-4 h-4 mr-2 text-neural-pink" fill="currentColor" viewBox="0 0 20 20"><path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd"/></svg>
                                活动专题报道
                            </div>
                        </div>
                    </div>
                    
                    <!-- 三等奖 -->
                    <div class="prize-card rounded-2xl p-6 reveal-section" style="animation-delay: 0.4s">
                        <div class="text-neural-green text-sm font-medium mb-2">三等奖</div>
                        <div class="prize-amount mb-4">¥50,000</div>
                        <div class="text-gray-400 text-sm mb-4">3名</div>
                        <div class="space-y-2">
                            <div class="flex items-center text-xs text-gray-300">
                                <svg class="w-4 h-4 mr-2 text-neural-green" fill="currentColor" viewBox="0 0 20 20"><path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd"/></svg>
                                创新先锋奖
                            </div>
                            <div class="flex items-center text-xs text-gray-300">
                                <svg class="w-4 h-4 mr-2 text-neural-green" fill="currentColor" viewBox="0 0 20 20"><path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd"/></svg>
                                云服务资源包（6个月）
                            </div>
                            <div class="flex items-center text-xs text-gray-300">
                                <svg class="w-4 h-4 mr-2 text-neural-green" fill="currentColor" viewBox="0 0 20 20"><path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd"/></svg>
                                社区焦点展示
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        
        <!-- Registration Section -->
        <section id="register" class="py-32 px-6">
            <div class="max-w-4xl mx-auto">
                <div class="text-center mb-12">
                    <h2 class="text-4xl md:text-6xl font-display font-bold mb-6 reveal-section">
                        立即报名
                    </h2>
                    <p class="text-gray-400 text-lg reveal-section">
                        准备好挑战AI极限了吗？填写下方信息完成报名。
                    </p>
                </div>
                
                <div class="glass rounded-2xl p-8 md:p-12 reveal-section">
                    <form id="registrationForm" class="space-y-6">
                        <div class="grid md:grid-cols-2 gap-6">
                            <div>
                                <label class="block text-sm font-medium text-gray-300 mb-2">团队名称</label>
                                <input type="text" class="w-full px-4 py-3 bg-gray-900/50 border border-gray-800 rounded-lg focus:outline-none focus:border-neural-blue focus:ring-1 focus:ring-neural-blue transition-all text-white placeholder-gray-600" placeholder="请输入团队名称" required>
                            </div>
                            <div>
                                <label class="block text-sm font-medium text-gray-300 mb-2">参赛形式</label>
                                <select class="w-full px-4 py-3 bg-gray-900/50 border border-gray-800 rounded-lg focus:outline-none focus:border-neural-blue focus:ring-1 focus:ring-neural-blue transition-all text-white">
                                    <option value="个人">个人参赛</option>
                                    <option value="团队">团队参赛</option>
                                    <option value="公司">公司参赛</option>
                                </select>
                            </div>
                        </div>
                        
                        <div class="grid md:grid-cols-2 gap-6">
                            <div>
                                <label class="block text-sm font-medium text-gray-300 mb-2">队长姓名</label>
                                <input type="text" class="w-full px-4 py-3 bg-gray-900/50 border border-gray-800 rounded-lg focus:outline-none focus:border-neural-blue focus:ring-1 focus:ring-neural-blue transition-all text-white placeholder-gray-600" placeholder="请输入队长姓名" required>
                            </div>
                            <div>
                                <label class="block text-sm font-medium text-gray-300 mb-2">联系电话</label>
                                <input type="tel" class="w-full px-4 py-3 bg-gray-900/50 border border-gray-800 rounded-lg focus:outline-none focus:border-neural-blue focus:ring-1 focus:ring-neural-blue transition-all text-white placeholder-gray-600" placeholder="请输入联系电话" required>
                            </div>
                        </div>
                        
                        <div>
                            <label class="block text-sm font-medium text-gray-300 mb-2">电子邮箱</label>
                            <input type="email" class="w-full px-4 py-3 bg-gray-900/50 border border-gray-800 rounded-lg focus:outline-none focus:border-neural-blue focus:ring-1 focus:ring-neural-blue transition-all text-white placeholder-gray-600" placeholder="请输入电子邮箱" required>
                            <p class="text-gray-500 text-xs mt-1">重要通知将通过此邮箱发送</p>
                        </div>
                        
                        <div>
                            <label class="block text-sm font-medium text-gray-300 mb-2">项目构想</label>
                            <textarea rows="4" class="w-full px-4 py-3 bg-gray-900/50 border border-gray-800 rounded-lg focus:outline-none focus:border-neural-blue focus:ring-1 focus:ring-neural-blue transition-all text-white placeholder-gray-600" placeholder="请简要描述您的AI项目构想、技术方案和创新点（300字以内）" required></textarea>
                        </div>
                        
                        <div class="bg-gray-900/30 rounded-lg p-4">
                            <div class="flex items-start">
                                <input type="checkbox" id="terms" class="mt-1 mr-3" required>
                                <label for="terms" class="text-sm text-gray-400">
                                    我已阅读并同意<a href="#" class="text-neural-blue hover:underline">《参赛协议》</a>，并确认所提交信息真实有效。报名费用为人民币5,000元，提交后将不可退还。
                                </label>
                            </div>
                        </div>
                        
                        <div class="pt-4">
                            <button type="submit" class="w-full py-4 rounded-full bg-gradient-to-r from-neural-blue to-neural-purple text-white font-bold text-lg hover:shadow-lg hover:shadow-neural-blue/30 transition-all dynamic-shadow">
                                提交报名并支付 ¥5,000
                            </button>
                        </div>
                    </form>
                </div>
                
                <div class="mt-12 text-center text-gray-500 text-sm">
                    <p>如有疑问，请联系：<a href="mailto:contact@ai-marathon.fun" class="text-neural-blue hover:underline">contact@ai-marathon.fun</a></p>
                </div>
            </div>
        </section>
        
        <!-- Footer -->
        <footer class="py-12 px-6 border-t border-gray-800">
            <div class="max-w-7xl mx-auto">
                <div class="grid md:grid-cols-3 gap-8 mb-8">
                    <div>
                        <h3 class="text-xl font-display font-bold mb-4">
                            <span class="text-gradient">AI</span>未来引擎
                        </h3>
                        <p class="text-gray-400 text-sm leading-relaxed">
                            汇聚全球AI创新力量，推动技术落地与应用。让智能改变世界。
                        </p>
                    </div>
                    <div>
                        <h4 class="text-sm font-semibold mb-4">快速链接</h4>
                        <ul class="space-y-2 text-sm text-gray-400">
                            <li><a href="#about" class="hover:text-neural-blue transition-colors">关于大赛</a></li>
                            <li><a href="#schedule" class="hover:text-neural-blue transition-colors">赛程与奖项</a></li>
                            <li><a href="#register" class="hover:text-neural-blue transition-colors">立即报名</a></li>
                        </ul>
                    </div>
                    <div>
                        <h4 class="text-sm font-semibold mb-4">联系我们</h4>
                        <ul class="space-y-2 text-sm text-gray-400">
                            <li>邮箱：contact@ai-marathon.fun</li>
                            <li>地址：中国·深圳</li>
                            <li>微信：AI_Marathon_2026</li>
                        </ul>
                    </div>
                </div>
                <div class="pt-8 border-t border-gray-800 text-center text-gray-500 text-xs">
                    <p>© 2026 AI未来引擎创新马拉松. All rights reserved. | Designed with ❤️ by StepFun</p>
                </div>
            </div>
        </footer>
    </main>
    
    <script>
        // 初始化 Lenis 平滑滚动
        const lenis = new Lenis({
            duration: 1.2,
            easing: (t) => Math.min(1, 1.001 - Math.pow(2, -10 * t)),
            direction: 'vertical',
            gestureDirection: 'vertical',
            smooth: true,
            mouseMultiplier: 1,
            smoothTouch: false,
            touchMultiplier: 2,
            infinite: false,
        });
        
        function raf(time) {
            lenis.raf(time);
            requestAnimationFrame(raf);
        }
        requestAnimationFrame(raf);
        
        // 将 Lenis 与 GSAP ScrollTrigger 同步
        gsap.registerPlugin(ScrollTrigger);
        
        // 页面加载完成后隐藏加载器
        window.addEventListener('load', () => {
            setTimeout(() => {
                document.getElementById('loader').classList.add('hidden');
                initAnimations();
            }, 1000);
        });
        
        // 光标跟随效果
        const cursorGlow = document.getElementById('cursorGlow');
        document.addEventListener('mousemove', (e) => {
            cursorGlow.style.left = e.clientX + 'px';
            cursorGlow.style.top = e.clientY + 'px';
        });
        
        // 磁性按钮效果
        document.querySelectorAll('.magnetic-btn').forEach(btn => {
            btn.addEventListener('mousemove', (e) => {
                const rect = btn.getBoundingClientRect();
                const x = e.clientX - rect.left - rect.width / 2;
                const y = e.clientY - rect.top - rect.height / 2;
                btn.style.transform = `translate(${x * 0.3}px, ${y * 0.3}px)`;
            });
            
            btn.addEventListener('mouseleave', () => {
                btn.style.transform = 'translate(0, 0)';
            });
        });
        
        // 神经网络背景
        class NeuralNetwork {
            constructor() {
                this.canvas = document.getElementById('neural-canvas');
                this.ctx = this.canvas.getContext('2d');
                this.nodes = [];
                this.connections = [];
                this.mouse = { x: null, y: null };
                
                this.resize();
                this.init();
                this.animate();
                
                window.addEventListener('resize', () => this.resize());
                window.addEventListener('mousemove', (e) => {
                    this.mouse.x = e.clientX;
                    this.mouse.y = e.clientY;
                });
            }
            
            resize() {
                this.canvas.width = window.innerWidth;
                this.canvas.height = window.innerHeight;
            }
            
            init() {
                const nodeCount = Math.floor((this.canvas.width * this.canvas.height) / 15000);
                for (let i = 0; i < nodeCount; i++) {
                    this.nodes.push({
                        x: Math.random() * this.canvas.width,
                        y: Math.random() * this.canvas.height,
                        vx: (Math.random() - 0.5) * 0.3,
                        vy: (Math.random() - 0.5) * 0.3,
                        radius: Math.random() * 2 + 1,
                        color: Math.random() > 0.5 ? '0, 212, 255' : '168, 85, 247'
                    });
                }
            }
            
            animate() {
                this.ctx.clearRect(0, 0, this.canvas.width, this.canvas.height);
                
                // 更新和绘制节点
                this.nodes.forEach(node => {
                    node.x += node.vx;
                    node.y += node.vy;
                    
                    // 边界反弹
                    if (node.x < 0 || node.x > this.canvas.width) node.vx *= -1;
                    if (node.y < 0 || node.y > this.canvas.height) node.vy *= -1;
                    
                    // 鼠标交互
                    if (this.mouse.x && this.mouse.y) {
                        const dx = this.mouse.x - node.x;
                        const dy = this.mouse.y - node.y;
                        const distance = Math.sqrt(dx * dx + dy * dy);
                        if (distance < 150) {
                            const force = (150 - distance) / 150;
                            node.x -= dx * force * 0.01;
                            node.y -= dy * force * 0.01;
                        }
                    }
                    
                    // 绘制节点
                    this.ctx.beginPath();
                    this.ctx.arc(node.x, node.y, node.radius, 0, Math.PI * 2);
                    this.ctx.fillStyle = `rgba(${node.color}, 0.6)`;
                    this.ctx.fill();
                });
                
                // 绘制连接线
                for (let i = 0; i < this.nodes.length; i++) {
                    for (let j = i + 1; j < this.nodes.length; j++) {
                        const nodeA = this.nodes[i];
                        const nodeB = this.nodes[j];
                        const dx = nodeA.x - nodeB.x;
                        const dy = nodeA.y - nodeB.y;
                        const distance = Math.sqrt(dx * dx + dy * dy);
                        
                        if (distance < 120) {
                            this.ctx.beginPath();
                            const opacity = (1 - distance / 120) * 0.3;
                            this.ctx.strokeStyle = `rgba(0, 212, 255, ${opacity})`;
                            this.ctx.lineWidth = 0.5;
                            this.ctx.moveTo(nodeA.x, nodeA.y);
                            this.ctx.lineTo(nodeB.x, nodeB.y);
                            this.ctx.stroke();
                        }
                    }
                }
                
                requestAnimationFrame(() => this.animate());
            }
        }
        
        // 初始化神经网络背景
        new NeuralNetwork();
        
        // GSAP 动画
        function initAnimations() {
            // Hero 文字动画
            gsap.from('.reveal-text', {
                y: 100,
                opacity: 0,
                duration: 1.2,
                stagger: 0.2,
                ease: 'power4.out',
                delay: 0.2
            });
            
            // 滚动触发动画
            gsap.utils.toArray('.reveal-section').forEach(section => {
                gsap.from(section, {
                    scrollTrigger: {
                        trigger: section,
                        start: 'top 80%',
                        toggleActions: 'play none none reverse'
                    },
                    y: 50,
                    opacity: 0,
                    duration: 1,
                    ease: 'power3.out'
                });
            });
            
            // 导航栏滚动效果
            ScrollTrigger.create({
                start: 'top -100',
                end: 99999,
                toggleClass: {className: 'py-2', targets: '#navbar'}
            });
            
            // 时间线动画
            gsap.from('.timeline-item', {
                scrollTrigger: {
                    trigger: '#schedule',
                    start: 'top 70%'
                },
                x: -50,
                opacity: 0,
                duration: 0.8,
                stagger: 0.2,
                ease: 'power2.out'
            });
            
            // 奖项卡片动画
            gsap.from('.prize-card', {
                scrollTrigger: {
                    trigger: '#schedule',
                    start: 'top 70%'
                },
                y: 100,
                opacity: 0,
                duration: 0.8,
                stagger: 0.1,
                ease: 'back.out(1.7)'
            });
        }
        
        // 表单提交
        document.getElementById('registrationForm').addEventListener('submit', (e) => {
            e.preventDefault();
            
            // 模拟提交成功
            const formData = new FormData(e.target);
            const data = Object.fromEntries(formData);
            
            // 这里可以添加实际的API调用
            console.log('报名信息：', data);
            
            // 显示成功消息
            alert('报名信息已提交！请完成支付流程。\n\n（注意：这是演示页面，实际支付功能未实现）');
            
            // 重置表单
            e.target.reset();
        });
        
        // 平滑滚动到锚点
        document.querySelectorAll('a[href^="#"]').forEach(anchor => {
            anchor.addEventListener('click', function (e) {
                e.preventDefault();
                const target = document.querySelector(this.getAttribute('href'));
                if (target) {
                    lenis.scrollTo(target, {
                        offset: -80,
                        duration: 1.5
                    });
                }
            });
        });
    </script>
</body>
</html>
